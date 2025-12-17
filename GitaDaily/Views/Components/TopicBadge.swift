import SwiftUI

struct TopicBadge: View {
    let topic: Topic

    var body: some View {
        HStack(spacing: 6) {
            Image(systemName: topic.icon)
                .font(.caption)
            Text(topic.rawValue)
                .font(.caption)
                .fontWeight(.medium)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 6)
        .background(topicColor.opacity(0.2))
        .foregroundStyle(topicColor)
        .cornerRadius(20)
    }

    private var topicColor: Color {
        switch topic.color {
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
}

#Preview {
    VStack(spacing: 12) {
        ForEach(Topic.allCases, id: \.self) { topic in
            TopicBadge(topic: topic)
        }
    }
    .padding()
}
