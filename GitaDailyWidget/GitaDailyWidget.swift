import WidgetKit
import SwiftUI

// MARK: - Timeline Entry

struct VerseEntry: TimelineEntry {
    let date: Date
    let verse: SharedVerseManager.WidgetVerse?
    let streak: Int
}

// MARK: - Timeline Provider

struct VerseTimelineProvider: TimelineProvider {

    func placeholder(in context: Context) -> VerseEntry {
        VerseEntry(
            date: Date(),
            verse: SharedVerseManager.sampleVerse,
            streak: 7
        )
    }

    func getSnapshot(in context: Context, completion: @escaping (VerseEntry) -> Void) {
        let entry = VerseEntry(
            date: Date(),
            verse: SharedVerseManager.loadVerse() ?? SharedVerseManager.sampleVerse,
            streak: SharedVerseManager.loadStreak()
        )
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<VerseEntry>) -> Void) {
        let currentDate = Date()
        let verse = SharedVerseManager.loadVerse()
        let streak = SharedVerseManager.loadStreak()

        let entry = VerseEntry(
            date: currentDate,
            verse: verse,
            streak: streak
        )

        // Update at midnight for new verse
        let calendar = Calendar.current
        let tomorrow = calendar.startOfDay(for: calendar.date(byAdding: .day, value: 1, to: currentDate)!)

        let timeline = Timeline(entries: [entry], policy: .after(tomorrow))
        completion(timeline)
    }
}

// MARK: - Widget Views

struct SmallWidgetView: View {
    let entry: VerseEntry

    var body: some View {
        if let verse = entry.verse {
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Image(systemName: "om")
                        .font(.caption)
                        .foregroundStyle(.orange)
                    Text(verse.reference)
                        .font(.caption)
                        .fontWeight(.semibold)
                    Spacer()
                }

                Text(verse.meaning)
                    .font(.caption2)
                    .foregroundStyle(.secondary)
                    .lineLimit(4)

                Spacer()

                HStack {
                    Image(systemName: verse.topicIcon)
                        .font(.caption2)
                    Text(verse.topic)
                        .font(.caption2)
                }
                .foregroundStyle(colorForString(verse.topicColor))
            }
            .padding()
        } else {
            PlaceholderView()
        }
    }
}

struct MediumWidgetView: View {
    let entry: VerseEntry

    var body: some View {
        if let verse = entry.verse {
            HStack(spacing: 16) {
                // Left side - Sanskrit
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Image(systemName: "om")
                            .foregroundStyle(.orange)
                        Text(verse.reference)
                            .font(.headline)
                    }

                    Text(verse.devanagari)
                        .font(.system(size: 14))
                        .lineLimit(3)
                        .foregroundStyle(.primary)

                    Spacer()

                    HStack(spacing: 4) {
                        Image(systemName: verse.topicIcon)
                        Text(verse.topic)
                    }
                    .font(.caption)
                    .foregroundStyle(colorForString(verse.topicColor))
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                Divider()

                // Right side - Meaning
                VStack(alignment: .leading, spacing: 8) {
                    Text("Meaning")
                        .font(.caption)
                        .foregroundStyle(.secondary)

                    Text(verse.meaning)
                        .font(.caption)
                        .lineLimit(5)

                    Spacer()

                    if entry.streak > 0 {
                        HStack(spacing: 4) {
                            Image(systemName: "flame.fill")
                                .foregroundStyle(.orange)
                            Text("\(entry.streak) day streak")
                        }
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding()
        } else {
            PlaceholderView()
        }
    }
}

struct LargeWidgetView: View {
    let entry: VerseEntry

    var body: some View {
        if let verse = entry.verse {
            VStack(alignment: .leading, spacing: 12) {
                // Header
                HStack {
                    Image(systemName: "om")
                        .font(.title2)
                        .foregroundStyle(.orange)
                    VStack(alignment: .leading) {
                        Text("Today's Verse")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        Text(verse.reference)
                            .font(.headline)
                    }
                    Spacer()
                    if entry.streak > 0 {
                        VStack(alignment: .trailing) {
                            Image(systemName: "flame.fill")
                                .foregroundStyle(.orange)
                            Text("\(entry.streak)")
                                .font(.caption)
                                .fontWeight(.bold)
                        }
                    }
                }

                // Devanagari
                Text(verse.devanagari)
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color(.systemGray6))
                    )

                // Transliteration
                Text(verse.transliteration)
                    .font(.caption)
                    .italic()
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)

                Divider()

                // Meaning
                VStack(alignment: .leading, spacing: 4) {
                    Text("Meaning")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Text(verse.meaning)
                        .font(.subheadline)
                }

                Spacer()

                // Topic badge
                HStack {
                    Spacer()
                    HStack(spacing: 6) {
                        Image(systemName: verse.topicIcon)
                        Text(verse.topic)
                    }
                    .font(.caption)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(colorForString(verse.topicColor).opacity(0.2))
                    .foregroundStyle(colorForString(verse.topicColor))
                    .cornerRadius(20)
                }
            }
            .padding()
        } else {
            PlaceholderView()
        }
    }
}

struct PlaceholderView: View {
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: "om")
                .font(.largeTitle)
                .foregroundStyle(.orange)
            Text("Gita Daily")
                .font(.headline)
            Text("Open the app to load today's verse")
                .font(.caption)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding()
    }
}

// MARK: - Helper

func colorForString(_ colorName: String) -> Color {
    switch colorName {
    case "blue": return .blue
    case "green": return .green
    case "purple": return .purple
    case "orange": return .orange
    case "red": return .red
    case "teal": return .teal
    case "indigo": return .indigo
    case "yellow": return .yellow
    case "pink": return .pink
    case "cyan": return .cyan
    default: return .gray
    }
}

// MARK: - Widget Configuration

struct GitaDailyWidget: Widget {
    let kind: String = "GitaDailyWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: VerseTimelineProvider()) { entry in
            GitaDailyWidgetEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
        .configurationDisplayName("Daily Verse")
        .description("See today's Bhagavad Gita verse at a glance.")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}

struct GitaDailyWidgetEntryView: View {
    @Environment(\.widgetFamily) var family
    let entry: VerseEntry

    var body: some View {
        switch family {
        case .systemSmall:
            SmallWidgetView(entry: entry)
        case .systemMedium:
            MediumWidgetView(entry: entry)
        case .systemLarge:
            LargeWidgetView(entry: entry)
        default:
            SmallWidgetView(entry: entry)
        }
    }
}

// MARK: - Widget Bundle

@main
struct GitaDailyWidgetBundle: WidgetBundle {
    var body: some Widget {
        GitaDailyWidget()
    }
}

// MARK: - Previews

#Preview("Small", as: .systemSmall) {
    GitaDailyWidget()
} timeline: {
    VerseEntry(date: Date(), verse: SharedVerseManager.sampleVerse, streak: 7)
}

#Preview("Medium", as: .systemMedium) {
    GitaDailyWidget()
} timeline: {
    VerseEntry(date: Date(), verse: SharedVerseManager.sampleVerse, streak: 7)
}

#Preview("Large", as: .systemLarge) {
    GitaDailyWidget()
} timeline: {
    VerseEntry(date: Date(), verse: SharedVerseManager.sampleVerse, streak: 7)
}
