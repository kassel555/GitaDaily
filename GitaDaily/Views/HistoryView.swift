import SwiftUI

struct HistoryView: View {
    @EnvironmentObject var verseService: DailyVerseService
    @EnvironmentObject var favoritesManager: FavoritesManager
    @State private var searchText = ""
    @State private var selectedTopic: Topic?
    @State private var showFavoritesOnly = false

    var filteredVerses: [Verse] {
        var verses = verseService.allVerses

        // Filter favorites first
        if showFavoritesOnly {
            verses = favoritesManager.getFavoriteVerses(from: verses)
        }

        // Then filter by topic
        if let topic = selectedTopic {
            verses = verses.filter { $0.topic == topic }
        }

        // Then filter by search
        if !searchText.isEmpty {
            let searchLower = searchText.lowercased()
            verses = verses.filter {
                $0.reference.lowercased().contains(searchLower) ||
                $0.meaning.lowercased().contains(searchLower) ||
                $0.explanation.lowercased().contains(searchLower) ||
                $0.topic.rawValue.lowercased().contains(searchLower)
            }
        }

        return verses
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                filterBar
                versesList
            }
            .navigationTitle("All Verses")
        }
    }

    // MARK: - Filter Bar

    private var filterBar: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                // Favorites filter (special)
                favoritesChip

                Divider()
                    .frame(height: 24)

                // All filter
                FilterChip(
                    title: "All",
                    isSelected: selectedTopic == nil && !showFavoritesOnly,
                    action: {
                        selectedTopic = nil
                        showFavoritesOnly = false
                    }
                )

                // Topic filters
                ForEach(Topic.allCases, id: \.self) { topic in
                    FilterChip(
                        title: topic.rawValue,
                        isSelected: selectedTopic == topic,
                        action: {
                            selectedTopic = topic
                            showFavoritesOnly = false
                        }
                    )
                }
            }
            .padding()
        }
        .background(Color(.systemBackground))
    }

    private var favoritesChip: some View {
        Button(action: {
            showFavoritesOnly.toggle()
            if showFavoritesOnly {
                selectedTopic = nil
            }
        }) {
            HStack(spacing: 6) {
                Image(systemName: showFavoritesOnly ? "heart.fill" : "heart")
                    .font(.caption)
                Text("Favorites")
                    .font(.subheadline)
                    .fontWeight(showFavoritesOnly ? .semibold : .regular)
                if !favoritesManager.favoriteVerseIds.isEmpty {
                    Text("(\(favoritesManager.favoriteVerseIds.count))")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(showFavoritesOnly ? Color.red.opacity(0.2) : Color(.systemGray6))
            .foregroundStyle(showFavoritesOnly ? .red : .primary)
            .cornerRadius(20)
        }
    }

    // MARK: - Verses List

    private var versesList: some View {
        Group {
            if filteredVerses.isEmpty {
                emptyStateView
            } else {
                List(filteredVerses) { verse in
                    NavigationLink {
                        VerseDetailView(verse: verse)
                    } label: {
                        VerseRow(
                            verse: verse,
                            isFavorite: favoritesManager.isFavorite(verse.id)
                        )
                    }
                }
                .listStyle(.plain)
            }
        }
        .searchable(text: $searchText, prompt: "Search verses...")
    }

    private var emptyStateView: some View {
        VStack(spacing: 16) {
            Image(systemName: showFavoritesOnly ? "heart.slash" : "magnifyingglass")
                .font(.system(size: 48))
                .foregroundStyle(.secondary)

            Text(showFavoritesOnly ? "No Favorites Yet" : "No Verses Found")
                .font(.headline)

            Text(showFavoritesOnly
                 ? "Tap the heart icon on any verse to add it to your favorites."
                 : "Try a different search term or filter.")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    HistoryView()
        .environmentObject(DailyVerseService())
        .environmentObject(AudioService())
        .environmentObject(FavoritesManager())
}
