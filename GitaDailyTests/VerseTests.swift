import XCTest
@testable import GitaDaily

final class VerseTests: XCTestCase {

    // MARK: - Reference Tests

    func test_reference_formatsCorrectly() {
        let verse = Verse(
            id: "2.47",
            chapter: 2,
            verse: 47,
            topic: .duty,
            devanagari: "कर्मण्येवाधिकारस्ते",
            transliteration: "karmaṇy-evādhikāras te",
            meaning: "You have the right to perform your duty",
            explanation: "Focus on action",
            audioFileName: nil
        )

        XCTAssertEqual(verse.reference, "BG 2.47", "Reference should be formatted as 'BG chapter.verse'")
    }

    func test_reference_formatsChapter1() {
        let verse = Verse(
            id: "1.1",
            chapter: 1,
            verse: 1,
            topic: .wisdom,
            devanagari: "धर्मक्षेत्रे",
            transliteration: "dharma-kṣetre",
            meaning: "On the sacred plain",
            explanation: "The battlefield",
            audioFileName: nil
        )

        XCTAssertEqual(verse.reference, "BG 1.1")
    }

    func test_reference_formatsChapter18() {
        let verse = Verse(
            id: "18.66",
            chapter: 18,
            verse: 66,
            topic: .devotion,
            devanagari: "सर्वधर्मान्परित्यज्य",
            transliteration: "sarva-dharmān parityajya",
            meaning: "Abandon all varieties of religion",
            explanation: "The final instruction",
            audioFileName: nil
        )

        XCTAssertEqual(verse.reference, "BG 18.66")
    }

    // MARK: - Codable Tests

    func test_verse_decodesFromJSON() throws {
        let json = """
        {
            "id": "2.47",
            "chapter": 2,
            "verse": 47,
            "topic": "Duty & Action",
            "devanagari": "कर्मण्येवाधिकारस्ते",
            "transliteration": "karmaṇy-evādhikāras te",
            "meaning": "You have the right to perform your duty",
            "explanation": "Focus on action",
            "audioFileName": null
        }
        """

        let data = json.data(using: .utf8)!
        let verse = try JSONDecoder().decode(Verse.self, from: data)

        XCTAssertEqual(verse.id, "2.47")
        XCTAssertEqual(verse.chapter, 2)
        XCTAssertEqual(verse.verse, 47)
        XCTAssertEqual(verse.topic, .duty)
        XCTAssertEqual(verse.devanagari, "कर्मण्येवाधिकारस्ते")
    }

    func test_verse_encodesToJSON() throws {
        let verse = Verse(
            id: "2.47",
            chapter: 2,
            verse: 47,
            topic: .duty,
            devanagari: "कर्मण्येवाधिकारस्ते",
            transliteration: "karmaṇy-evādhikāras te",
            meaning: "You have the right to perform your duty",
            explanation: "Focus on action",
            audioFileName: nil
        )

        let data = try JSONEncoder().encode(verse)
        let decodedVerse = try JSONDecoder().decode(Verse.self, from: data)

        XCTAssertEqual(decodedVerse.id, verse.id)
        XCTAssertEqual(decodedVerse.topic, verse.topic)
    }

    // MARK: - Hashable Tests

    func test_verse_isHashable() {
        let verse1 = Verse(
            id: "2.47",
            chapter: 2,
            verse: 47,
            topic: .duty,
            devanagari: "test",
            transliteration: "test",
            meaning: "test",
            explanation: "test",
            audioFileName: nil
        )

        let verse2 = Verse(
            id: "2.47",
            chapter: 2,
            verse: 47,
            topic: .duty,
            devanagari: "test",
            transliteration: "test",
            meaning: "test",
            explanation: "test",
            audioFileName: nil
        )

        XCTAssertEqual(verse1.hashValue, verse2.hashValue, "Same verses should have same hash")
    }

    // MARK: - Identifiable Tests

    func test_verse_id_isUnique() {
        let verse1 = Verse(
            id: "2.47",
            chapter: 2,
            verse: 47,
            topic: .duty,
            devanagari: "test",
            transliteration: "test",
            meaning: "test",
            explanation: "test",
            audioFileName: nil
        )

        let verse2 = Verse(
            id: "3.14",
            chapter: 3,
            verse: 14,
            topic: .karma,
            devanagari: "test",
            transliteration: "test",
            meaning: "test",
            explanation: "test",
            audioFileName: nil
        )

        XCTAssertNotEqual(verse1.id, verse2.id)
    }
}
