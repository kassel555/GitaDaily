import Foundation
import AVFoundation
import Combine

final class AudioService: NSObject, ObservableObject {

    // MARK: - Published Properties

    @Published var isPlaying = false
    @Published var currentRepeat = 0
    @Published var pronunciationMode: PronunciationMode = .romanized

    // MARK: - Configuration

    struct Config {
        static let normalRate: Float = AVSpeechUtteranceDefaultSpeechRate * 0.75
        static let slowRate: Float = AVSpeechUtteranceMinimumSpeechRate * 1.3
        static let preDelay: TimeInterval = 0.1
        static let postDelay: TimeInterval = 0.3
        static let phaseDelay: TimeInterval = 0.5
        static let repeatDelay: TimeInterval = 0.8
    }

    // MARK: - Private Properties

    private let synthesizer = AVSpeechSynthesizer()
    private var playbackState = PlaybackState()

    // MARK: - Initialization

    override init() {
        super.init()
        synthesizer.delegate = self
        configureAudioSession()
    }

    // MARK: - Public Methods

    func speak(devanagari: String, transliteration: String, english: String = "", repeats: Int = 1, slowSpeed: Bool = false) {
        guard !isPlaying else { return }

        // Convert Devanagari to phonetic English for romanized mode
        let romanizedText = TransliterationCleaner.devanagariToEnglishPhonetic(devanagari)

        playbackState = PlaybackState(
            devanagari: devanagari,
            romanized: TransliterationCleaner.syllabify(romanizedText),
            transliteration: TransliterationCleaner.clean(transliteration),
            english: english,
            totalRepeats: repeats,
            slowSpeed: slowSpeed
        )

        // Set initial phase based on mode
        switch pronunciationMode {
        case .romanized:
            playbackState.phase = .romanized
        case .devanagari, .both:
            playbackState.phase = .devanagari
        case .transliteration:
            playbackState.phase = .transliteration
        case .english:
            playbackState.phase = .english
        }

        speakCurrentPhase()
    }

    func stop() {
        synthesizer.stopSpeaking(at: .immediate)
        resetState()
    }

    func pause() {
        synthesizer.pauseSpeaking(at: .word)
    }

    func resume() {
        synthesizer.continueSpeaking()
    }

    // MARK: - Private Methods

    private func configureAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .spokenAudio)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Audio session configuration failed: \(error)")
        }
    }

    private func speakCurrentPhase() {
        let (text, voice) = textAndVoice(for: playbackState.phase)

        let utterance = createUtterance(text: text, voice: voice)

        isPlaying = true
        currentRepeat += 1
        synthesizer.speak(utterance)
    }

    private func textAndVoice(for phase: SpeakingPhase) -> (String, AVSpeechSynthesisVoice?) {
        switch pronunciationMode {
        case .romanized:
            return (playbackState.romanized, VoiceManager.bestVoice(for: .romanized, phase: .romanized))
        case .devanagari:
            return (playbackState.devanagari, VoiceManager.bestVoice(for: .devanagari, phase: .devanagari))
        case .transliteration:
            return (playbackState.transliteration, VoiceManager.bestVoice(for: .transliteration, phase: .transliteration))
        case .english:
            return (playbackState.english, VoiceManager.bestVoice(for: .english, phase: .english))
        case .both:
            let voice = VoiceManager.bestVoice(for: .both, phase: phase)
            switch phase {
            case .romanized:
                return (playbackState.romanized, voice)
            case .devanagari:
                return (playbackState.devanagari, voice)
            case .transliteration:
                return (playbackState.transliteration, voice)
            case .english:
                return (playbackState.english, voice)
            }
        }
    }

    private func createUtterance(text: String, voice: AVSpeechSynthesisVoice?) -> AVSpeechUtterance {
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = voice
        utterance.rate = playbackState.slowSpeed ? Config.slowRate : Config.normalRate
        utterance.pitchMultiplier = 1.0
        utterance.volume = 1.0
        utterance.preUtteranceDelay = Config.preDelay
        utterance.postUtteranceDelay = Config.postDelay
        return utterance
    }

    private func handlePhaseCompletion() {
        // In "both" mode, speak English meaning after devanagari
        if pronunciationMode == .both && playbackState.phase == .devanagari {
            playbackState.phase = .english
            currentRepeat -= 1 // Don't count phase switch as repeat
            scheduleNextUtterance(delay: Config.phaseDelay)
            return
        }

        // Handle repeats
        if currentRepeat < playbackState.totalRepeats {
            // Reset to initial phase based on mode
            switch pronunciationMode {
            case .romanized:
                playbackState.phase = .romanized
            case .devanagari, .both:
                playbackState.phase = .devanagari
            case .transliteration:
                playbackState.phase = .transliteration
            case .english:
                playbackState.phase = .english
            }
            scheduleNextUtterance(delay: Config.repeatDelay)
        } else {
            resetState()
        }
    }

    private func scheduleNextUtterance(delay: TimeInterval) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) { [weak self] in
            self?.speakCurrentPhase()
        }
    }

    private func resetState() {
        isPlaying = false
        currentRepeat = 0
        playbackState.phase = .devanagari
    }
}

// MARK: - AVSpeechSynthesizerDelegate

extension AudioService: AVSpeechSynthesizerDelegate {

    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        handlePhaseCompletion()
    }

    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didStart utterance: AVSpeechUtterance) {
        isPlaying = true
    }

    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didCancel utterance: AVSpeechUtterance) {
        resetState()
    }
}

// MARK: - Playback State

private struct PlaybackState {
    var devanagari: String = ""
    var romanized: String = ""
    var transliteration: String = ""
    var english: String = ""
    var totalRepeats: Int = 1
    var slowSpeed: Bool = false
    var phase: SpeakingPhase = .romanized
}
