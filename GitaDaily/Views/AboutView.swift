import SwiftUI

struct AboutView: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    // App Icon
                    Image(systemName: "om")
                        .font(.system(size: 80))
                        .foregroundStyle(.orange)
                        .padding()

                    Text("Gita Daily")
                        .font(.title)
                        .fontWeight(.bold)

                    Text("Learn one Bhagavad Gita verse every day")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)

                    Divider()
                        .padding(.horizontal)

                    // Features
                    VStack(alignment: .leading, spacing: 16) {
                        FeatureRow(
                            icon: "book.fill",
                            title: "Curated Topics",
                            description: "Verses organized by themes like stress, duty, wisdom, and devotion"
                        )

                        FeatureRow(
                            icon: "speaker.wave.3.fill",
                            title: "Audio Pronunciation",
                            description: "Listen to proper Sanskrit pronunciation with speed and repeat controls"
                        )

                        FeatureRow(
                            icon: "flame.fill",
                            title: "Daily Streaks",
                            description: "Build a consistent practice with daily reminders and streak tracking"
                        )

                        FeatureRow(
                            icon: "brain.head.profile",
                            title: "Deep Understanding",
                            description: "Clear English meanings and practical explanations for modern life"
                        )
                    }
                    .padding()

                    Divider()
                        .padding(.horizontal)

                    Text("The Bhagavad Gita is one of the most profound spiritual texts, offering timeless wisdom for navigating life's challenges with clarity, courage, and compassion.")
                        .font(.body)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                        .padding()

                    Text("Made with 🧡 for spiritual seekers everywhere")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .padding(.bottom)
                }
                .padding()
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    AboutView()
}
