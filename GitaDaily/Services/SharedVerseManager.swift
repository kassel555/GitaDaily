import Foundation
import WidgetKit

/// Shared data manager for communicating between main app and widget
/// Uses App Groups for shared UserDefaults access
struct SharedVerseManager {

    // MARK: - App Group Configuration

    static let appGroupIdentifier = "group.com.rahulkassel.gitadaily"

    static var sharedDefaults: UserDefaults? {
        UserDefaults(suiteName: appGroupIdentifier)
    }

    // MARK: - Keys

    private enum Keys {
        static let todayVerse = "todayVerse"
        static let lastUpdated = "lastUpdated"
        static let currentStreak = "currentStreak"
    }

    // MARK: - Shared Verse Data

    struct WidgetVerse: Codable {
        let id: String
        let reference: String
        let devanagari: String
        let transliteration: String
        let meaning: String
        let topic: String
        let topicIcon: String
        let topicColor: String
    }

    // MARK: - Read/Write Methods

    static func saveVerse(_ verse: Verse) {
        let widgetVerse = WidgetVerse(
            id: verse.id,
            reference: verse.reference,
            devanagari: verse.devanagari,
            transliteration: verse.transliteration,
            meaning: verse.meaning,
            topic: verse.topic.rawValue,
            topicIcon: verse.topic.icon,
            topicColor: verse.topic.color
        )

        if let encoded = try? JSONEncoder().encode(widgetVerse) {
            sharedDefaults?.set(encoded, forKey: Keys.todayVerse)
            sharedDefaults?.set(Date(), forKey: Keys.lastUpdated)
        }

        // Reload widget timelines
        WidgetCenter.shared.reloadAllTimelines()
    }

    static func loadVerse() -> WidgetVerse? {
        guard let data = sharedDefaults?.data(forKey: Keys.todayVerse),
              let verse = try? JSONDecoder().decode(WidgetVerse.self, from: data) else {
            return nil
        }
        return verse
    }

    static func saveStreak(_ streak: Int) {
        sharedDefaults?.set(streak, forKey: Keys.currentStreak)
    }

    static func loadStreak() -> Int {
        sharedDefaults?.integer(forKey: Keys.currentStreak) ?? 0
    }

    static func lastUpdated() -> Date? {
        sharedDefaults?.object(forKey: Keys.lastUpdated) as? Date
    }

    // MARK: - Sample Data for Preview

    static var sampleVerse: WidgetVerse {
        WidgetVerse(
            id: "2.47",
            reference: "BG 2.47",
            devanagari: "कर्मण्येवाधिकारस्ते मा फलेषु कदाचन",
            transliteration: "karmaṇy-evādhikāras te",
            meaning: "You have the right to perform your duty, but never to the fruits of action.",
            topic: "Duty & Action",
            topicIcon: "checkmark.circle.fill",
            topicColor: "blue"
        )
    }
}
