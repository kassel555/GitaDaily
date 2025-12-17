import Foundation

struct TransliterationCleaner {

    // MARK: - IAST to Phonetic Mappings

    private static let phoneticReplacements: [(String, String)] = [
        // Long vowels
        ("ā", "aa"),
        ("ī", "ee"),
        ("ū", "oo"),

        // Vocalic R and L
        ("ṛ", "ri"),
        ("ṝ", "ree"),
        ("ḷ", "lri"),

        // Anusvara and Visarga
        ("ṁ", "m"),
        ("ṃ", "m"),
        ("ḥ", "ha"),

        // Nasals
        ("ñ", "nya"),
        ("ṅ", "ng"),
        ("ṇ", "n"),

        // Retroflex consonants
        ("ṭ", "t"),
        ("ḍ", "d"),

        // Sibilants
        ("ś", "sh"),
        ("ṣ", "sh"),

        // Word separators (add pause)
        ("-", ", ")
    ]

    // MARK: - Public Methods

    static func clean(_ text: String) -> String {
        var result = text

        for (original, replacement) in phoneticReplacements {
            result = result.replacingOccurrences(of: original, with: replacement)
        }

        return result
    }
}
