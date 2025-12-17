import SwiftUI

struct VerseRow: View {
    let verse: Verse
    var isFavorite: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(verse.reference)
                    .font(.headline)
                if isFavorite {
                    Image(systemName: "heart.fill")
                        .font(.caption)
                        .foregroundStyle(.red)
                }
                Spacer()
                TopicBadge(topic: verse.topic)
            }

            Text(verse.meaning)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .lineLimit(2)
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    VStack {
        VerseRow(
            verse: Verse(
                id: "2.47",
                chapter: 2,
                verse: 47,
                topic: .duty,
                devanagari: "कर्मण्येवाधिकारस्ते",
                transliteration: "karmaṇy-evādhikāras te",
                meaning: "You have the right to perform your duty, but never to the fruits of action.",
                explanation: "Focus on action, not results.",
                audioFileName: nil
            ),
            isFavorite: false
        )

        VerseRow(
            verse: Verse(
                id: "18.66",
                chapter: 18,
                verse: 66,
                topic: .devotion,
                devanagari: "सर्वधर्मान्परित्यज्य",
                transliteration: "sarva-dharmān parityajya",
                meaning: "Abandon all forms of dharma and simply surrender unto Me.",
                explanation: "Complete surrender.",
                audioFileName: nil
            ),
            isFavorite: true
        )
    }
    .padding()
}
