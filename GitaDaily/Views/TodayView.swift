import SwiftUI

struct TodayView: View {
    @EnvironmentObject var verseService: DailyVerseService
    @EnvironmentObject var audioService: AudioService
    @EnvironmentObject var favoritesManager: FavoritesManager
    @State private var showTransliteration = true
    @State private var slowSpeed = false
    @State private var repeatCount = 1
    @State private var isMarkedLearned = false

    var body: some View {
        NavigationStack {
            ScrollView {
                if let verse = verseService.todayVerse {
                    VStack(spacing: 24) {
                        headerSection(verse: verse)
                        verseReferenceSection(verse: verse)
                        devanagariSection(verse: verse)
                        transliterationSection(verse: verse)
                        audioControlsSection(verse: verse)
                        Divider().padding(.horizontal)
                        meaningSection(verse: verse)
                        explanationSection(verse: verse)
                        markLearnedButton
                    }
                } else {
                    loadingView
                }
            }
            .navigationTitle("Today's Verse")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    HStack(spacing: 16) {
                        if let verse = verseService.todayVerse {
                            FavoriteButton(
                                isFavorite: favoritesManager.isFavorite(verse.id),
                                action: { favoritesManager.toggleFavorite(for: verse) }
                            )
                        }
                        Button(action: { showTransliteration.toggle() }) {
                            Image(systemName: showTransliteration ? "eye.fill" : "eye.slash.fill")
                        }
                    }
                }
            }
        }
    }

    // MARK: - Header Section

    private func headerSection(verse: Verse) -> some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text("Day \(verseService.currentStreak)")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Text("\(verseService.currentStreak) day streak 🔥")
                    .font(.headline)
            }
            Spacer()
            TopicBadge(topic: verse.topic)
        }
        .padding(.horizontal)
        .padding(.top)
    }

    // MARK: - Verse Sections

    private func verseReferenceSection(verse: Verse) -> some View {
        Text(verse.reference)
            .font(.title2)
            .fontWeight(.bold)
    }

    private func devanagariSection(verse: Verse) -> some View {
        Text(verse.devanagari)
            .font(.title3)
            .multilineTextAlignment(.center)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color(.systemBackground))
                    .shadow(color: .black.opacity(0.1), radius: 8, y: 4)
            )
            .padding(.horizontal)
    }

    @ViewBuilder
    private func transliterationSection(verse: Verse) -> some View {
        if showTransliteration {
            Text(verse.transliteration)
                .font(.body)
                .foregroundStyle(.secondary)
                .italic()
                .multilineTextAlignment(.center)
                .padding(.horizontal)
        }
    }

    private func meaningSection(verse: Verse) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Meaning")
                .font(.headline)
                .foregroundStyle(.secondary)
            Text(verse.meaning)
                .font(.title3)
                .fontWeight(.medium)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal)
    }

    private func explanationSection(verse: Verse) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Explanation")
                .font(.headline)
                .foregroundStyle(.secondary)
            Text(verse.explanation)
                .font(.body)
                .foregroundStyle(.primary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal)
    }

    // MARK: - Audio Controls

    @ViewBuilder
    private func audioControlsSection(verse: Verse) -> some View {
        VStack(spacing: 16) {
            playButton(verse: verse)
            audioOptionsRow
        }
    }

    private func playButton(verse: Verse) -> some View {
        Button(action: {
            if audioService.isPlaying {
                audioService.stop()
            } else {
                audioService.speak(
                    devanagari: verse.devanagari,
                    transliteration: verse.transliteration,
                    english: verse.meaning,
                    repeats: repeatCount,
                    slowSpeed: slowSpeed
                )
            }
        }) {
            HStack(spacing: 12) {
                Image(systemName: audioService.isPlaying ? "stop.circle.fill" : "play.circle.fill")
                    .font(.title)
                Text(audioService.isPlaying ? "Stop" : "Play Pronunciation")
                    .fontWeight(.semibold)
                if audioService.isPlaying && audioService.currentRepeat > 0 {
                    Text("(\(audioService.currentRepeat)/\(repeatCount))")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(audioService.isPlaying ? Color.red.opacity(0.2) : Color.accentColor.opacity(0.2))
            .foregroundStyle(audioService.isPlaying ? .red : .accentColor)
            .cornerRadius(12)
        }
        .padding(.horizontal)
    }

    private var audioOptionsRow: some View {
        HStack(spacing: 20) {
            slowSpeedButton
            repeatCountMenu
        }
        .padding(.horizontal)
    }

    private var slowSpeedButton: some View {
        Button(action: { slowSpeed.toggle() }) {
            VStack(spacing: 4) {
                Image(systemName: "tortoise.fill")
                    .font(.title2)
                Text("Slow")
                    .font(.caption)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(slowSpeed ? Color.blue.opacity(0.2) : Color(.systemGray6))
            .foregroundStyle(slowSpeed ? .blue : .secondary)
            .cornerRadius(10)
        }
    }

    private var repeatCountMenu: some View {
        Menu {
            ForEach(1...5, id: \.self) { count in
                Button("\(count)x") { repeatCount = count }
            }
        } label: {
            VStack(spacing: 4) {
                Image(systemName: "repeat")
                    .font(.title2)
                Text("\(repeatCount)x")
                    .font(.caption)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color(.systemGray6))
            .foregroundStyle(.secondary)
            .cornerRadius(10)
        }
    }

    // MARK: - Actions

    private var markLearnedButton: some View {
        Button(action: { isMarkedLearned.toggle() }) {
            HStack {
                Image(systemName: isMarkedLearned ? "checkmark.circle.fill" : "circle")
                Text(isMarkedLearned ? "Learned" : "Mark as Learned")
                    .fontWeight(.medium)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(isMarkedLearned ? Color.green : Color.accentColor)
            .foregroundStyle(.white)
            .cornerRadius(12)
        }
        .padding(.horizontal)
        .padding(.bottom)
    }

    private var loadingView: some View {
        VStack(spacing: 16) {
            ProgressView()
            Text("Loading today's verse...")
                .foregroundStyle(.secondary)
        }
        .frame(maxHeight: .infinity)
    }
}

#Preview {
    TodayView()
        .environmentObject(DailyVerseService())
        .environmentObject(AudioService())
        .environmentObject(FavoritesManager())
}
