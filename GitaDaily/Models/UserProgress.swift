import Foundation
import SwiftData

@Model
class UserProgress {
    var currentStreak: Int
    var longestStreak: Int
    var lastOpenedDate: Date
    var totalVersesLearned: Int
    var notificationTime: Date
    var useSlowSpeed: Bool
    var repeatCount: Int
    var showTransliteration: Bool
    
    init(
        currentStreak: Int = 0,
        longestStreak: Int = 0,
        lastOpenedDate: Date = Date(),
        totalVersesLearned: Int = 0,
        notificationTime: Date = Calendar.current.date(bySettingHour: 8, minute: 0, second: 0, of: Date()) ?? Date(),
        useSlowSpeed: Bool = false,
        repeatCount: Int = 1,
        showTransliteration: Bool = true
    ) {
        self.currentStreak = currentStreak
        self.longestStreak = longestStreak
        self.lastOpenedDate = lastOpenedDate
        self.totalVersesLearned = totalVersesLearned
        self.notificationTime = notificationTime
        self.useSlowSpeed = useSlowSpeed
        self.repeatCount = repeatCount
        self.showTransliteration = showTransliteration
    }
}

@Model
class VerseHistory {
    var verseId: String
    var learnedDate: Date
    var isFavorite: Bool
    var playCount: Int
    
    init(verseId: String, learnedDate: Date = Date(), isFavorite: Bool = false, playCount: Int = 0) {
        self.verseId = verseId
        self.learnedDate = learnedDate
        self.isFavorite = isFavorite
        self.playCount = playCount
    }
}
