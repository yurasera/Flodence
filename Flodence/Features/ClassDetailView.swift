import SwiftUI

struct ClassDetailView: View {
    private enum DetailTab: String, CaseIterable, Identifiable {
        case overview = "Overview"
        case learners = "Learners"
        case sessions = "Sessions"

        var id: Self { self }
    }

    @State private var selectedTab: DetailTab = .overview

    var body: some View {
        VStack(spacing: 0) {
            Picker("Class detail", selection: $selectedTab) {
                ForEach(DetailTab.allCases) { tab in
                    Text(tab.rawValue).tag(tab)
                }
            }
            .pickerStyle(.segmented)
            .padding(.horizontal, 20)
            .padding(.vertical, 12)

            Group {
                switch selectedTab {
                case .overview: OverviewTab()
                case .learners: LearnersTab()
                case .sessions: SessionsTab()
                }
            }
        }
        .background(Color(uiColor: .systemGroupedBackground))
        .navigationTitle("Web Development")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Menu {
                    Button("Edit class", systemImage: "pencil") { }
                    Button("Share class", systemImage: "square.and.arrow.up") { }
                } label: {
                    Image(systemName: "ellipsis.circle")
                }
            }
        }
    }
}

private struct OverviewTab: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Web Development")
                        .font(.title.bold())
                    Text("Build practical, modern websites from the ground up.")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(20)
                .background(.background, in: RoundedRectangle(cornerRadius: 20, style: .continuous))

                HStack(spacing: 12) {
                    DetailMetric(value: "16", label: "Learners", symbol: "person.2.fill", color: .teal)
                    DetailMetric(value: "8", label: "Sessions", symbol: "calendar", color: AppColor.indigo)
                }

                Text("Next session")
                    .font(.title3.bold())
                HStack(spacing: 14) {
                    Image(systemName: "calendar.badge.clock")
                        .font(.title2)
                        .foregroundStyle(.teal)
                        .frame(width: 44, height: 44)
                        .background(Color.teal.opacity(0.14), in: RoundedRectangle(cornerRadius: 12, style: .continuous))
                    VStack(alignment: .leading, spacing: 3) {
                        Text("HTML & CSS foundations").font(.headline)
                        Text("Friday, 10:00 · Lab 2").font(.subheadline).foregroundStyle(.secondary)
                    }
                    Spacer()
                }
                .padding(16)
                .background(.background, in: RoundedRectangle(cornerRadius: 18, style: .continuous))
            }
            .padding(20)
        }
    }
}

private struct LearnersTab: View {
    private let learners = [("Alya Rahman", "AR", Color.pink), ("Bima Santoso", "BS", Color.blue), ("Citra Maheswari", "CM", Color.orange), ("Dimas Pratama", "DP", Color.teal)]

    var body: some View {
        List {
            Section("16 learners") {
                ForEach(learners, id: \.0) { learner in
                    HStack(spacing: 12) {
                        Avatar(initials: learner.1, color: learner.2)
                        Text(learner.0).font(.headline)
                        Spacer()
                        Text("Active").font(.caption.weight(.medium)).foregroundStyle(.green)
                    }
                    .padding(.vertical, 3)
                }
            }
        }
        .listStyle(.insetGrouped)
    }
}

private struct SessionsTab: View {
    var body: some View {
        List {
            Section("Upcoming") {
                SessionRow(title: "HTML & CSS foundations", time: "Fri, 10:00 · Lab 2", symbol: "calendar.badge.clock", color: .teal)
                SessionRow(title: "Responsive layouts", time: "Tue, 10:00 · Lab 2", symbol: "calendar", color: AppColor.indigo)
            }
            Section("Completed") {
                SessionRow(title: "Introduction to the web", time: "Completed · Sep 19", symbol: "checkmark.circle.fill", color: .green)
            }
        }
        .listStyle(.insetGrouped)
    }
}

private struct DetailMetric: View {
    let value: String
    let label: String
    let symbol: String
    let color: Color

    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: symbol).foregroundStyle(color)
            VStack(alignment: .leading, spacing: 2) {
                Text(value).font(.title3.bold())
                Text(label).font(.caption).foregroundStyle(.secondary)
            }
            Spacer(minLength: 0)
        }
        .padding(16)
        .frame(maxWidth: .infinity)
        .background(.background, in: RoundedRectangle(cornerRadius: 18, style: .continuous))
    }
}

private struct SessionRow: View {
    let title: String
    let time: String
    let symbol: String
    let color: Color

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: symbol).foregroundStyle(color)
            VStack(alignment: .leading, spacing: 3) {
                Text(title).font(.headline)
                Text(time).font(.subheadline).foregroundStyle(.secondary)
            }
        }
        .padding(.vertical, 3)
    }
}
