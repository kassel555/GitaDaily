import Foundation
import SwiftData
import Combine

@MainActor
class FavoritesManager: ObservableObject {

    @Published private(set) var favoriteVerseIds: Set<String> = []

    private var modelContext: ModelContext?

    init() {}

    // MARK: - Setup

    func configure(with modelContext: ModelContext) {
        self.modelContext = modelContext
        loadFavorites()
    }

    // MARK: - Public Methods

    func isFavorite(_ verseId: String) -> Bool {
        favoriteVerseIds.contains(verseId)
    }

    func toggleFavorite(for verse: Verse) {
        if isFavorite(verse.id) {
            removeFavorite(verseId: verse.id)
        } else {
            addFavorite(for: verse)
        }
    }

    func addFavorite(for verse: Verse) {
        guard let modelContext else { return }

        let history = VerseHistory(verseId: verse.id, isFavorite: true)
        modelContext.insert(history)
        saveContext()

        favoriteVerseIds.insert(verse.id)
    }

    func removeFavorite(verseId: String) {
        guard let modelContext else { return }

        let descriptor = FetchDescriptor<VerseHistory>(
            predicate: #Predicate { $0.verseId == verseId }
        )

        if let existing = try? modelContext.fetch(descriptor).first {
            existing.isFavorite = false
            saveContext()
        }

        favoriteVerseIds.remove(verseId)
    }

    func getFavoriteVerses(from allVerses: [Verse]) -> [Verse] {
        allVerses.filter { favoriteVerseIds.contains($0.id) }
    }

    // MARK: - Private Methods

    private func loadFavorites() {
        guard let modelContext else { return }

        let descriptor = FetchDescriptor<VerseHistory>(
            predicate: #Predicate { $0.isFavorite == true }
        )

        do {
            let favorites = try modelContext.fetch(descriptor)
            favoriteVerseIds = Set(favorites.map { $0.verseId })
        } catch {
            print("Failed to load favorites: \(error)")
        }
    }

    private func saveContext() {
        guard let modelContext else { return }

        do {
            try modelContext.save()
        } catch {
            print("Failed to save context: \(error)")
        }
    }
}
