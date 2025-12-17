import Foundation

struct TransliterationCleaner {

    // MARK: - IAST to Phonetic Mappings (for English TTS)

    private static let phoneticReplacements: [(String, String)] = [
        // Long vowels - elongate for clarity
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
        ("ḥ", "hah"),

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

        // Chandrabindu
        ("̐", "n")
    ]

    // MARK: - Devanagari to Phonetic Mappings

    private static let devanagariToPhonetic: [(String, String)] = [
        // Vowels
        ("अ", "uh"), ("आ", "aa"), ("इ", "i"), ("ई", "ee"),
        ("उ", "u"), ("ऊ", "oo"), ("ऋ", "ri"), ("ॠ", "ree"),
        ("ए", "ay"), ("ऐ", "ai"), ("ओ", "o"), ("औ", "au"),

        // Vowel marks (matras)
        ("ा", "aa"), ("ि", "i"), ("ी", "ee"),
        ("ु", "u"), ("ू", "oo"), ("ृ", "ri"),
        ("े", "ay"), ("ै", "ai"), ("ो", "o"), ("ौ", "au"),

        // Consonants with inherent 'a'
        ("क", "ka"), ("ख", "kha"), ("ग", "ga"), ("घ", "gha"), ("ङ", "nga"),
        ("च", "cha"), ("छ", "chha"), ("ज", "ja"), ("झ", "jha"), ("ञ", "nya"),
        ("ट", "ta"), ("ठ", "tha"), ("ड", "da"), ("ढ", "dha"), ("ण", "na"),
        ("त", "tha"), ("थ", "thha"), ("द", "dha"), ("ध", "dhha"), ("न", "na"),
        ("प", "pa"), ("फ", "pha"), ("ब", "ba"), ("भ", "bha"), ("म", "ma"),
        ("य", "ya"), ("र", "ra"), ("ल", "la"), ("व", "va"),
        ("श", "sha"), ("ष", "sha"), ("स", "sa"), ("ह", "ha"),

        // Special characters
        ("ं", "m"), ("ः", "ha"), ("ँ", "n"),
        ("्", ""), // Virama - removes inherent vowel

        // Numerals
        ("०", "0"), ("१", "1"), ("२", "2"), ("३", "3"), ("४", "4"),
        ("५", "5"), ("६", "6"), ("७", "7"), ("८", "8"), ("९", "9"),

        // Punctuation
        ("।", "."), ("॥", "..")
    ]

    // MARK: - Public Methods

    /// Clean IAST transliteration for English TTS
    static func clean(_ text: String) -> String {
        var result = text

        for (original, replacement) in phoneticReplacements {
            result = result.replacingOccurrences(of: original, with: replacement)
        }

        // Add slight pauses between words for natural rhythm
        result = addNaturalPauses(to: result)

        return result
    }

    /// Convert Devanagari to phonetic English for TTS
    static func devanagariToEnglishPhonetic(_ text: String) -> String {
        var result = text

        // First pass: convert conjuncts and special combinations
        result = handleConjuncts(result)

        // Second pass: convert individual characters
        for (devanagari, phonetic) in devanagariToPhonetic {
            result = result.replacingOccurrences(of: devanagari, with: phonetic)
        }

        // Clean up double vowels and awkward combinations
        result = cleanupPhonetics(result)

        // Add natural pauses
        result = addNaturalPauses(to: result)

        return result
    }

    /// Break text into syllables with pauses for clearer pronunciation
    static func syllabify(_ text: String) -> String {
        var result = text

        // Add micro-pauses after long compound words
        let words = result.components(separatedBy: " ")
        let processedWords = words.map { word -> String in
            if word.count > 10 {
                return insertSyllableBreaks(in: word)
            }
            return word
        }

        result = processedWords.joined(separator: "  ")  // Double space between words
        return result
    }

    // MARK: - Private Methods

    private static func handleConjuncts(_ text: String) -> String {
        var result = text

        // Common Sanskrit conjuncts
        let conjuncts: [(String, String)] = [
            ("क्ष", "ksha"),
            ("त्र", "tra"),
            ("ज्ञ", "gya"),
            ("श्र", "shra"),
            ("द्व", "dva"),
            ("त्व", "tva"),
            ("स्व", "sva"),
            ("न्य", "nya"),
            ("द्य", "dya"),
            ("स्य", "sya"),
            ("त्य", "tya"),
            ("र्म", "rma"),
            ("र्व", "rva"),
            ("र्य", "rya"),
            ("र्थ", "rtha"),
            ("र्ध", "rdha"),
            ("र्न", "rna"),
            ("र्ष", "rsha"),
            ("ष्ट", "shta"),
            ("ष्ठ", "shtha"),
            ("क्त", "kta"),
            ("ग्र", "gra"),
            ("प्र", "pra"),
            ("ब्र", "bra"),
            ("द्र", "dra"),
            ("स्थ", "stha"),
            ("न्त", "nta"),
            ("न्द", "nda"),
            ("म्ब", "mba"),
            ("ङ्ग", "nga"),
            ("ञ्च", "ncha"),
            ("ञ्ज", "nja")
        ]

        for (conjunct, phonetic) in conjuncts {
            result = result.replacingOccurrences(of: conjunct, with: phonetic)
        }

        return result
    }

    private static func cleanupPhonetics(_ text: String) -> String {
        var result = text

        // Remove awkward double consonants
        result = result.replacingOccurrences(of: "aa a", with: "aa")
        result = result.replacingOccurrences(of: "ee i", with: "ee")
        result = result.replacingOccurrences(of: "oo u", with: "oo")

        // Clean up virama remnants
        result = result.replacingOccurrences(of: "a्", with: "")
        result = result.replacingOccurrences(of: "्a", with: "")

        // Smooth out repeated sounds
        result = result.replacingOccurrences(of: "  ", with: " ")

        return result
    }

    private static func addNaturalPauses(to text: String) -> String {
        var result = text

        // Add pauses after punctuation
        result = result.replacingOccurrences(of: ",", with: ", , ")
        result = result.replacingOccurrences(of: ".", with: ". . ")

        // Add slight pause for hyphens (word breaks in transliteration)
        result = result.replacingOccurrences(of: "-", with: " , ")

        // Add pause before certain words for rhythm
        let pauseWords = ["na", "cha", "va", "tu", "hi", "eva"]
        for word in pauseWords {
            result = result.replacingOccurrences(of: " \(word) ", with: " , \(word) ")
        }

        return result
    }

    private static func insertSyllableBreaks(in word: String) -> String {
        // Simple syllable breaking: insert micro-pause every 4-5 characters
        var result = ""
        var count = 0

        for char in word {
            result.append(char)
            count += 1

            // Insert break after vowels in long words
            if count >= 4 && "aeiou".contains(char.lowercased()) {
                result.append(" ")
                count = 0
            }
        }

        return result
    }
}
