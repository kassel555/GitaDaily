import SwiftUI

struct FeatureRow: View {
    let icon: String
    let title: String
    let description: String

    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundStyle(.orange)
                .frame(width: 32)

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)
                Text(description)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
        }
    }
}

#Preview {
    VStack(alignment: .leading, spacing: 16) {
        FeatureRow(
            icon: "book.fill",
            title: "Curated Topics",
            description: "Verses organized by themes like stress, duty, wisdom, and devotion"
        )
        FeatureRow(
            icon: "speaker.wave.3.fill",
            title: "Audio Pronunciation",
            description: "Listen to proper Sanskrit pronunciation"
        )
    }
    .padding()
}
