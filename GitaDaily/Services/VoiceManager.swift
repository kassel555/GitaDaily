import AVFoundation

struct VoiceManager {

    // MARK: - Voice Identifiers

    private static let preferredHindiVoices = [
        "com.apple.voice.premium.hi-IN.Lekha",
        "com.apple.voice.enhanced.hi-IN.Lekha",
        "com.apple.ttsbundle.Lekha-premium"
    ]

    private static let preferredIndianEnglishVoices = [
        "com.apple.voice.premium.en-IN.Sangeeta",
        "com.apple.voice.enhanced.en-IN.Sangeeta",
        "com.apple.ttsbundle.siri_Nicky_en-IN_compact"
    ]

    private static let preferredEnglishVoices = [
        "com.apple.voice.premium.en-US.Samantha",
        "com.apple.voice.enhanced.en-US.Samantha",
        "com.apple.ttsbundle.siri_Samantha_en-US_compact"
    ]

    // MARK: - Public Methods

    static func bestVoice(for mode: PronunciationMode, phase: SpeakingPhase) -> AVSpeechSynthesisVoice? {
        switch (mode, phase) {
        case (.devanagari, _), (.both, .devanagari):
            return bestHindiVoice()
        case (.transliteration, _), (.both, .transliteration):
            return bestIndianEnglishVoice()
        case (.english, _), (.both, .english):
            return bestEnglishVoice()
        }
    }

    static func loadAvailableVoices() -> [AVSpeechSynthesisVoice] {
        let allVoices = AVSpeechSynthesisVoice.speechVoices()

        let sanskritVoices = allVoices.filter { $0.language.hasPrefix("sa") }
        let hindiVoices = filterAndSort(allVoices, languagePrefix: "hi")
        let indianEnglishVoices = filterAndSort(allVoices, language: "en-IN")

        return sanskritVoices + hindiVoices + indianEnglishVoices
    }

    // MARK: - Private Methods

    private static func bestHindiVoice() -> AVSpeechSynthesisVoice? {
        findPreferredVoice(from: preferredHindiVoices)
            ?? AVSpeechSynthesisVoice.speechVoices()
                .filter { $0.language.hasPrefix("hi") }
                .sorted { qualityScore($0) > qualityScore($1) }
                .first
            ?? AVSpeechSynthesisVoice(language: "hi-IN")
    }

    private static func bestIndianEnglishVoice() -> AVSpeechSynthesisVoice? {
        findPreferredVoice(from: preferredIndianEnglishVoices)
            ?? AVSpeechSynthesisVoice.speechVoices()
                .filter { $0.language == "en-IN" }
                .sorted { qualityScore($0) > qualityScore($1) }
                .first
            ?? AVSpeechSynthesisVoice(language: "en-IN")
    }

    private static func bestEnglishVoice() -> AVSpeechSynthesisVoice? {
        findPreferredVoice(from: preferredEnglishVoices)
            ?? AVSpeechSynthesisVoice.speechVoices()
                .filter { $0.language.hasPrefix("en-US") }
                .sorted { qualityScore($0) > qualityScore($1) }
                .first
            ?? AVSpeechSynthesisVoice(language: "en-US")
    }

    private static func findPreferredVoice(from identifiers: [String]) -> AVSpeechSynthesisVoice? {
        for identifier in identifiers {
            if let voice = AVSpeechSynthesisVoice(identifier: identifier) {
                return voice
            }
        }
        return nil
    }

    private static func filterAndSort(_ voices: [AVSpeechSynthesisVoice], languagePrefix: String) -> [AVSpeechSynthesisVoice] {
        voices
            .filter { $0.language.hasPrefix(languagePrefix) }
            .sorted { qualityScore($0) > qualityScore($1) }
    }

    private static func filterAndSort(_ voices: [AVSpeechSynthesisVoice], language: String) -> [AVSpeechSynthesisVoice] {
        voices
            .filter { $0.language == language }
            .sorted { qualityScore($0) > qualityScore($1) }
    }

    private static func qualityScore(_ voice: AVSpeechSynthesisVoice) -> Int {
        switch voice.quality {
        case .premium: return 3
        case .enhanced: return 2
        case .default: return 1
        @unknown default: return 0
        }
    }
}

// MARK: - Speaking Phase

enum SpeakingPhase {
    case devanagari
    case transliteration
    case english

    var next: SpeakingPhase? {
        switch self {
        case .devanagari: return .transliteration
        case .transliteration: return nil
        case .english: return nil
        }
    }
}
