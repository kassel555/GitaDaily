import SwiftUI

struct FavoriteButton: View {
    let isFavorite: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: isFavorite ? "heart.fill" : "heart")
                .font(.title2)
                .foregroundStyle(isFavorite ? .red : .secondary)
                .contentTransition(.symbolEffect(.replace))
        }
        .buttonStyle(.plain)
        .accessibilityLabel(isFavorite ? "Remove from favorites" : "Add to favorites")
    }
}

// Compact version for list rows
struct FavoriteIndicator: View {
    let isFavorite: Bool

    var body: some View {
        if isFavorite {
            Image(systemName: "heart.fill")
                .font(.caption)
                .foregroundStyle(.red)
        }
    }
}

#Preview {
    VStack(spacing: 20) {
        FavoriteButton(isFavorite: false, action: {})
        FavoriteButton(isFavorite: true, action: {})

        HStack {
            Text("Verse 2.47")
            Spacer()
            FavoriteIndicator(isFavorite: true)
        }
        .padding()
    }
}
