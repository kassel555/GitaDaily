import Foundation
import Combine
import WidgetKit

class DailyVerseService: ObservableObject {
    @Published var todayVerse: Verse? {
        didSet {
            // Share with widget when verse changes
            if let verse = todayVerse {
                SharedVerseManager.saveVerse(verse)
            }
        }
    }
    @Published var allVerses: [Verse] = []
    @Published var currentStreak: Int = 0 {
        didSet {
            // Share streak with widget
            SharedVerseManager.saveStreak(currentStreak)
        }
    }
    @Published var longestStreak: Int = 0

    private let startDate: Date = {
        let calendar = Calendar.current
        var components = DateComponents()
        components.year = 2025
        components.month = 1
        components.day = 1
        return calendar.date(from: components)!
    }()

    // Curated topic rotation: ensures variety across themes
    private let topicRotation: [Topic] = [
        .duty,      // Monday: Start week with purpose
        .stress,    // Tuesday: Manage challenges
        .discipline, // Wednesday: Build habits
        .wisdom,    // Thursday: Reflect deeply
        .devotion,  // Friday: Connect spiritually
        .karma,     // Saturday: Understand action
        .courage    // Sunday: Face fears
    ]

    init() {
        loadVerses()
        selectTodayVerse()
    }

    private func loadVerses() {
        guard let url = Bundle.main.url(forResource: "verses", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let verses = try? JSONDecoder().decode([Verse].self, from: data) else {
            print("Failed to load verses")
            return
        }
        self.allVerses = verses
    }

    func selectTodayVerse() {
        guard !allVerses.isEmpty else { return }

        let calendar = Calendar.current
        let daysSinceStart = calendar.dateComponents([.day], from: startDate, to: Date()).day ?? 0

        // Use day of week to determine topic (0 = Sunday, 1 = Monday, etc.)
        let dayOfWeek = calendar.component(.weekday, from: Date())
        let topicIndex = (dayOfWeek - 1) % topicRotation.count
        let todayTopic = topicRotation[topicIndex]

        // Get all verses for today's topic
        let versesForTopic = allVerses.filter { $0.topic == todayTopic }

        // Rotate through verses within the topic
        if !versesForTopic.isEmpty {
            let verseIndex = (daysSinceStart / 7) % versesForTopic.count
            todayVerse = versesForTopic[verseIndex]
        }
    }

    func checkAndUpdateStreak() {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())

        // In a real app, load this from SwiftData
        // For now, using published properties
        let lastOpenedDate = calendar.startOfDay(for: Date().addingTimeInterval(-86400)) // Yesterday

        if calendar.isDate(lastOpenedDate, inSameDayAs: today) {
            // Already opened today
            return
        } else if calendar.isDate(lastOpenedDate, inSameDayAs: today.addingTimeInterval(-86400)) {
            // Opened yesterday, increment streak
            currentStreak += 1
            longestStreak = max(longestStreak, currentStreak)
        } else {
            // Streak broken
            currentStreak = 1
        }
    }

    func getVersesByTopic(_ topic: Topic) -> [Verse] {
        allVerses.filter { $0.topic == topic }
    }

    func searchVerses(query: String) -> [Verse] {
        if query.isEmpty { return allVerses }

        let lowercasedQuery = query.lowercased()
        return allVerses.filter {
            $0.reference.lowercased().contains(lowercasedQuery) ||
            $0.meaning.lowercased().contains(lowercasedQuery) ||
            $0.explanation.lowercased().contains(lowercasedQuery) ||
            $0.topic.rawValue.lowercased().contains(lowercasedQuery)
        }
    }

    /// Force refresh widget data
    func refreshWidget() {
        if let verse = todayVerse {
            SharedVerseManager.saveVerse(verse)
        }
        SharedVerseManager.saveStreak(currentStreak)
        WidgetCenter.shared.reloadAllTimelines()
    }
}
