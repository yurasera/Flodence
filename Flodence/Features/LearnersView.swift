import SwiftUI

struct LearnersView: View {
    @State private var query = ""
    private let learners = [("Alya Rahman", "Visual Design Fundamentals", "AR", Color.pink), ("Bima Santoso", "Product Strategy", "BS", Color.blue), ("Citra Maheswari", "Creative Coding", "CM", Color.orange), ("Dimas Pratama", "Visual Design Fundamentals", "DP", Color.teal)]
    var body: some View {
        NavigationStack {
            List {
                Section("86 learners") {
                    ForEach(filteredLearners, id: \.0) { learner in
                        HStack(spacing: 12) { Avatar(initials: learner.2, color: learner.3); VStack(alignment: .leading, spacing: 3) { Text(learner.0).font(.headline); Text(learner.1).font(.subheadline).foregroundStyle(.secondary) }; Spacer(); Image(systemName: "chevron.right").font(.footnote.weight(.semibold)).foregroundStyle(.tertiary) }.padding(.vertical, 3)
                    }
                }
            }
            .navigationTitle("Learners")
            .searchable(text: $query, prompt: "Search learners")
            .toolbar { ToolbarItem(placement: .topBarTrailing) { Button { } label: { Image(systemName: "person.badge.plus") }.accessibilityLabel("Add learner") } }
        }
    }
    private var filteredLearners: [(String, String, String, Color)] { query.isEmpty ? learners : learners.filter { $0.0.localizedCaseInsensitiveContains(query) } }
}
