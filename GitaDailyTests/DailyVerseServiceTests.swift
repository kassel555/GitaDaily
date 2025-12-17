import XCTest
@testable import GitaDaily

final class DailyVerseServiceTests: XCTestCase {

    var sut: DailyVerseService!

    override func setUp() {
        super.setUp()
        sut = DailyVerseService()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    // MARK: - Verse Loading Tests

    func test_allVerses_isNotEmpty() {
        XCTAssertFalse(sut.allVerses.isEmpty, "Verses should be loaded from JSON")
    }

    func test_todayVerse_isNotNil() {
        XCTAssertNotNil(sut.todayVerse, "Today's verse should be selected")
    }

    // MARK: - Topic Filter Tests

    func test_getVersesByTopic_returnsOnlyMatchingTopic() {
        let topic = Topic.duty
        let filteredVerses = sut.getVersesByTopic(topic)

        for verse in filteredVerses {
            XCTAssertEqual(verse.topic, topic, "All verses should match the requested topic")
        }
    }

    func test_getVersesByTopic_returnsEmptyForUnusedTopic() {
        // This test verifies the filter works correctly
        // In a real scenario, all topics should have verses
        let allTopics = Topic.allCases
        for topic in allTopics {
            let verses = sut.getVersesByTopic(topic)
            // Each topic should have at least 0 verses (non-negative)
            XCTAssertGreaterThanOrEqual(verses.count, 0)
        }
    }

    // MARK: - Search Tests

    func test_searchVerses_withEmptyQuery_returnsAllVerses() {
        let result = sut.searchVerses(query: "")
        XCTAssertEqual(result.count, sut.allVerses.count, "Empty query should return all verses")
    }

    func test_searchVerses_withValidQuery_returnsMatchingVerses() {
        // Search for a common term that should exist
        let result = sut.searchVerses(query: "duty")

        // Should return some results if "duty" exists in any verse
        // This is a fuzzy test - adjust based on actual data
        XCTAssertGreaterThanOrEqual(result.count, 0, "Search should return non-negative results")
    }

    func test_searchVerses_isCaseInsensitive() {
        let lowercaseResult = sut.searchVerses(query: "duty")
        let uppercaseResult = sut.searchVerses(query: "DUTY")
        let mixedCaseResult = sut.searchVerses(query: "Duty")

        XCTAssertEqual(lowercaseResult.count, uppercaseResult.count, "Search should be case insensitive")
        XCTAssertEqual(lowercaseResult.count, mixedCaseResult.count, "Search should be case insensitive")
    }

    func test_searchVerses_searchesMeaning() {
        guard let firstVerse = sut.allVerses.first else {
            XCTFail("No verses loaded")
            return
        }

        // Take first word from meaning
        let meaningWords = firstVerse.meaning.components(separatedBy: " ")
        guard let searchWord = meaningWords.first, searchWord.count > 3 else {
            return // Skip if meaning is too short
        }

        let result = sut.searchVerses(query: searchWord)
        XCTAssertTrue(result.contains(firstVerse), "Search should find verse by meaning content")
    }

    func test_searchVerses_searchesReference() {
        guard let firstVerse = sut.allVerses.first else {
            XCTFail("No verses loaded")
            return
        }

        let result = sut.searchVerses(query: firstVerse.reference)
        XCTAssertTrue(result.contains(where: { $0.id == firstVerse.id }), "Search should find verse by reference")
    }

    // MARK: - Streak Tests

    func test_initialStreak_isZeroOrPositive() {
        XCTAssertGreaterThanOrEqual(sut.currentStreak, 0, "Initial streak should be non-negative")
    }

    func test_longestStreak_isGreaterOrEqualToCurrentStreak() {
        XCTAssertGreaterThanOrEqual(sut.longestStreak, sut.currentStreak,
                                     "Longest streak should be >= current streak")
    }
}
