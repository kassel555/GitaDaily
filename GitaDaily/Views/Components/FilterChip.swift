import SwiftUI

struct FilterChip: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.subheadline)
                .fontWeight(isSelected ? .semibold : .regular)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(isSelected ? Color.accentColor : Color(.systemGray6))
                .foregroundStyle(isSelected ? .white : .primary)
                .cornerRadius(20)
        }
    }
}

#Preview {
    HStack {
        FilterChip(title: "All", isSelected: true, action: {})
        FilterChip(title: "Wisdom", isSelected: false, action: {})
        FilterChip(title: "Duty", isSelected: false, action: {})
    }
    .padding()
}
