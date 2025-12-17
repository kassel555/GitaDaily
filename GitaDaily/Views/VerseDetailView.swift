import SwiftUI

struct VerseDetailView: View {
    let verse: Verse
    @EnvironmentObject var audioService: AudioService
    @EnvironmentObject var favoritesManager: FavoritesManager
    @State private var showTransliteration = true

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Reference & Topic
                VStack(spacing: 8) {
                    Text(verse.reference)
                        .font(.title2)
                        .fontWeight(.bold)
                    TopicBadge(topic: verse.topic)
                }

                // Devanagari
                Text(verse.devanagari)
                    .font(.title3)
                    .multilineTextAlignment(.center)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color(.systemGray6))
                    )
                    .padding(.horizontal)

                // Transliteration
                if showTransliteration {
                    Text(verse.transliteration)
                        .font(.body)
                        .foregroundStyle(.secondary)
                        .italic()
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }

                // Play Button
                Button(action: {
                    audioService.speak(devanagari: verse.devanagari, transliteration: verse.transliteration, english: verse.meaning)
                }) {
                    HStack {
                        Image(systemName: "play.circle.fill")
                        Text("Play")
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.accentColor.opacity(0.2))
                    .foregroundStyle(Color.accentColor)
                    .cornerRadius(12)
                }
                .padding(.horizontal)

                Divider()
                    .padding(.horizontal)

                // Meaning
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

                // Explanation
                VStack(alignment: .leading, spacing: 12) {
                    Text("Explanation")
                        .font(.headline)
                        .foregroundStyle(.secondary)
                    Text(verse.explanation)
                        .font(.body)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                .padding(.bottom)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                HStack(spacing: 16) {
                    FavoriteButton(
                        isFavorite: favoritesManager.isFavorite(verse.id),
                        action: { favoritesManager.toggleFavorite(for: verse) }
                    )
                    Button(action: { showTransliteration.toggle() }) {
                        Image(systemName: showTransliteration ? "eye.fill" : "eye.slash.fill")
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        VerseDetailView(verse: Verse(
            id: "2.47",
            chapter: 2,
            verse: 47,
            topic: .duty,
            devanagari: "कर्मण्येवाधिकारस्ते मा फलेषु कदाचन",
            transliteration: "karmaṇy-evādhikāras te mā phaleṣu kadācana",
            meaning: "You have the right to perform your duty, but never to the fruits of action.",
            explanation: "This famous verse teaches us to focus on our actions rather than being attached to their outcomes.",
            audioFileName: nil
        ))
        .environmentObject(AudioService())
        .environmentObject(FavoritesManager())
    }
}
