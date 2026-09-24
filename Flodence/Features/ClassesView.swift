import SwiftUI

struct ClassesView: View {
    var body: some View {
        NavigationStack {
            List {
                Section("Active classes") {
                    ClassListRow(title: "Desain Grafis", subtitle: "24 learners · Next: Today, 08:00", color: .orange)
                    ClassListRow(title: "Coding Games", subtitle: "18 learners · Next: Today, 10:00", color: AppColor.indigo)
                    NavigationLink {
                        ClassDetailView()
                    } label: {
                        ClassListRow(title: "Web Development", subtitle: "16 learners · Next: Fri, 10:00", color: .teal)
                    }
                }
                Section("Drafts") { ClassListRow(title: "Mobile Development", subtitle: "8 learners · Not published", color: .gray) }
            }
            .navigationTitle("Classes")
            .toolbar { ToolbarItem(placement: .topBarTrailing) { Button { } label: { Image(systemName: "plus") }.accessibilityLabel("Create class") } }
        }
    }
}

private struct ClassListRow: View { let title: String; let subtitle: String; let color: Color; var body: some View { HStack(spacing: 13) { Image(systemName: "book.closed.fill").foregroundStyle(color).frame(width: 38, height: 38).background(color.opacity(0.14), in: RoundedRectangle(cornerRadius: 10, style: .continuous)); VStack(alignment: .leading, spacing: 3) { Text(title).font(.headline); Text(subtitle).font(.subheadline).foregroundStyle(.secondary) } }.padding(.vertical, 3) } }
