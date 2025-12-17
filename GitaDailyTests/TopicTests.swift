import XCTest
@testable import GitaDaily

final class TopicTests: XCTestCase {

    // MARK: - All Cases Tests

    func test_allCases_contains10Topics() {
        XCTAssertEqual(Topic.allCases.count, 10, "Should have 10 topics")
    }

    func test_allCases_containsExpectedTopics() {
        let topics = Topic.allCases

        XCTAssertTrue(topics.contains(.duty))
        XCTAssertTrue(topics.contains(.stress))
        XCTAssertTrue(topics.contains(.wisdom))
        XCTAssertTrue(topics.contains(.devotion))
        XCTAssertTrue(topics.contains(.discipline))
        XCTAssertTrue(topics.contains(.detachment))
        XCTAssertTrue(topics.contains(.karma))
        XCTAssertTrue(topics.contains(.knowledge))
        XCTAssertTrue(topics.contains(.courage))
        XCTAssertTrue(topics.contains(.purpose))
    }

    // MARK: - Raw Value Tests

    func test_rawValue_dutyAndAction() {
        XCTAssertEqual(Topic.duty.rawValue, "Duty & Action")
    }

    func test_rawValue_stressAndAnxiety() {
        XCTAssertEqual(Topic.stress.rawValue, "Stress & Anxiety")
    }

    func test_rawValue_wisdom() {
        XCTAssertEqual(Topic.wisdom.rawValue, "Wisdom")
    }

    func test_rawValue_devotion() {
        XCTAssertEqual(Topic.devotion.rawValue, "Devotion")
    }

    func test_rawValue_karmaYoga() {
        XCTAssertEqual(Topic.karma.rawValue, "Karma Yoga")
    }

    // MARK: - Icon Tests

    func test_icon_duty_hasCheckmark() {
        XCTAssertEqual(Topic.duty.icon, "checkmark.circle.fill")
    }

    func test_icon_stress_hasHeart() {
        XCTAssertEqual(Topic.stress.icon, "heart.fill")
    }

    func test_icon_wisdom_hasBrain() {
        XCTAssertEqual(Topic.wisdom.icon, "brain.head.profile")
    }

    func test_icon_devotion_hasFlame() {
        XCTAssertEqual(Topic.devotion.icon, "flame.fill")
    }

    func test_icon_discipline_hasTarget() {
        XCTAssertEqual(Topic.discipline.icon, "target")
    }

    func test_icon_detachment_hasLeaf() {
        XCTAssertEqual(Topic.detachment.icon, "leaf.fill")
    }

    func test_icon_karma_hasCirclePath() {
        XCTAssertEqual(Topic.karma.icon, "arrow.triangle.2.circlepath")
    }

    func test_icon_knowledge_hasBook() {
        XCTAssertEqual(Topic.knowledge.icon, "book.fill")
    }

    func test_icon_courage_hasShield() {
        XCTAssertEqual(Topic.courage.icon, "shield.fill")
    }

    func test_icon_purpose_hasCompass() {
        XCTAssertEqual(Topic.purpose.icon, "compass.fill")
    }

    func test_allTopics_haveValidIcons() {
        for topic in Topic.allCases {
            XCTAssertFalse(topic.icon.isEmpty, "\(topic) should have a non-empty icon")
        }
    }

    // MARK: - Color Tests

    func test_color_duty_isBlue() {
        XCTAssertEqual(Topic.duty.color, "blue")
    }

    func test_color_stress_isGreen() {
        XCTAssertEqual(Topic.stress.color, "green")
    }

    func test_color_wisdom_isPurple() {
        XCTAssertEqual(Topic.wisdom.color, "purple")
    }

    func test_color_devotion_isOrange() {
        XCTAssertEqual(Topic.devotion.color, "orange")
    }

    func test_color_discipline_isRed() {
        XCTAssertEqual(Topic.discipline.color, "red")
    }

    func test_color_detachment_isTeal() {
        XCTAssertEqual(Topic.detachment.color, "teal")
    }

    func test_color_karma_isIndigo() {
        XCTAssertEqual(Topic.karma.color, "indigo")
    }

    func test_color_knowledge_isYellow() {
        XCTAssertEqual(Topic.knowledge.color, "yellow")
    }

    func test_color_courage_isPink() {
        XCTAssertEqual(Topic.courage.color, "pink")
    }

    func test_color_purpose_isCyan() {
        XCTAssertEqual(Topic.purpose.color, "cyan")
    }

    func test_allTopics_haveValidColors() {
        let validColors = ["blue", "green", "purple", "orange", "red", "teal", "indigo", "yellow", "pink", "cyan"]

        for topic in Topic.allCases {
            XCTAssertTrue(validColors.contains(topic.color),
                         "\(topic) should have a valid color, got: \(topic.color)")
        }
    }

    func test_allTopics_haveUniqueColors() {
        let colors = Topic.allCases.map { $0.color }
        let uniqueColors = Set(colors)

        XCTAssertEqual(colors.count, uniqueColors.count, "Each topic should have a unique color")
    }

    // MARK: - Codable Tests

    func test_topic_decodesFromRawValue() throws {
        let json = "\"Duty & Action\""
        let data = json.data(using: .utf8)!

        let topic = try JSONDecoder().decode(Topic.self, from: data)
        XCTAssertEqual(topic, .duty)
    }

    func test_topic_encodesToRawValue() throws {
        let topic = Topic.duty
        let data = try JSONEncoder().encode(topic)
        let string = String(data: data, encoding: .utf8)

        XCTAssertEqual(string, "\"Duty & Action\"")
    }
}
