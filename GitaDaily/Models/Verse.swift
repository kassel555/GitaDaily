import Foundation

struct Verse: Codable, Identifiable, Hashable {
    let id: String
    let chapter: Int
    let verse: Int
    let topic: Topic
    let devanagari: String
    let transliteration: String
    let meaning: String
    let explanation: String
    let audioFileName: String?
    
    var reference: String {
        "BG \(chapter).\(verse)"
    }
}

enum Topic: String, Codable, CaseIterable {
    case duty = "Duty & Action"
    case stress = "Stress & Anxiety"
    case wisdom = "Wisdom"
    case devotion = "Devotion"
    case discipline = "Discipline"
    case detachment = "Detachment"
    case karma = "Karma Yoga"
    case knowledge = "Knowledge"
    case courage = "Courage"
    case purpose = "Purpose"
    case mindfulness = "Mindfulness"
    case peace = "Peace"
    case faith = "Faith"
    case compassion = "Compassion"

    var icon: String {
        switch self {
        case .duty: return "checkmark.circle.fill"
        case .stress: return "heart.fill"
        case .wisdom: return "brain.head.profile"
        case .devotion: return "flame.fill"
        case .discipline: return "target"
        case .detachment: return "leaf.fill"
        case .karma: return "arrow.triangle.2.circlepath"
        case .knowledge: return "book.fill"
        case .courage: return "shield.fill"
        case .purpose: return "compass.fill"
        case .mindfulness: return "eye.fill"
        case .peace: return "water.waves"
        case .faith: return "hands.clap.fill"
        case .compassion: return "hand.raised.fill"
        }
    }

    var color: String {
        switch self {
        case .duty: return "blue"
        case .stress: return "green"
        case .wisdom: return "purple"
        case .devotion: return "orange"
        case .discipline: return "red"
        case .detachment: return "teal"
        case .karma: return "indigo"
        case .knowledge: return "yellow"
        case .courage: return "pink"
        case .purpose: return "cyan"
        case .mindfulness: return "mint"
        case .peace: return "blue"
        case .faith: return "purple"
        case .compassion: return "pink"
        }
    }
}
