import Foundation

enum PronunciationMode: String, CaseIterable, Codable {
    case devanagari = "Sanskrit (Devanagari)"
    case transliteration = "Transliteration (IAST)"
    case english = "English Meaning"
    case both = "Sanskrit + English"

    var usesDevanagari: Bool {
        self == .devanagari || self == .both
    }

    var usesTransliteration: Bool {
        self == .transliteration
    }

    var usesEnglish: Bool {
        self == .english || self == .both
    }
}
