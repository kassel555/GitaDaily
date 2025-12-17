import Foundation

enum PronunciationMode: String, CaseIterable, Codable {
    case romanized = "Romanized Sanskrit"
    case transliteration = "Transliteration (IAST)"
    case devanagari = "Sanskrit (Devanagari)"
    case english = "English Meaning"
    case both = "Sanskrit + English"

    var description: String {
        switch self {
        case .romanized:
            return "Clear English voice reading phonetic Sanskrit"
        case .transliteration:
            return "Indian English voice with IAST text"
        case .devanagari:
            return "Hindi voice reading Devanagari script"
        case .english:
            return "English voice reading the meaning"
        case .both:
            return "Sanskrit followed by English meaning"
        }
    }

    var usesDevanagari: Bool {
        self == .devanagari || self == .both
    }

    var usesTransliteration: Bool {
        self == .transliteration
    }

    var usesRomanized: Bool {
        self == .romanized
    }

    var usesEnglish: Bool {
        self == .english || self == .both
    }
}
