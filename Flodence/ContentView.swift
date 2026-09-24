//
//  ContentView.swift
//  Flodence
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            DashboardView()
                .tabItem { Label("Dashboard", systemImage: "square.grid.2x2.fill") }

            ClassesView()
                .tabItem { Label("Classes", systemImage: "book.closed.fill") }

            LearnersView()
                .tabItem { Label("Learners", systemImage: "person.2.fill") }
        }
        .tint(AppColor.indigo)
    }
}

private enum AppColor {
    static let indigo = Color(red: 0.29, green: 0.30, blue: 0.82)
    static let lavender = Color(red: 0.94, green: 0.94, blue: 1.0)
    static let ink = Color(red: 0.10, green: 0.11, blue: 0.18)
}

private struct DashboardView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    header
                    progressCard
                    sectionTitle("Today’s classes", action: "See all")
                    VStack(spacing: 12) {
                        ClassRow(time: "09:00", title: "Visual Design Fundamentals", detail: "24 learners · Studio A", color: .orange)
                        ClassRow(time: "13:30", title: "Product Strategy", detail: "18 learners · Online", color: AppColor.indigo)
                    }
                    sectionTitle("Your learners", action: "View learners")
                    learnerPreview
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 24)
            }
            .background(Color(uiColor: .systemGroupedBackground))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Text("Flodence").font(.title2.weight(.bold)).foregroundStyle(AppColor.ink)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button { } label: {
                        Image(systemName: "bell").font(.body.weight(.semibold))
                    }
                    .accessibilityLabel("Notifications")
                }
            }
        }
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Wednesday, September 24")
                .font(.subheadline).foregroundStyle(.secondary)
            Text("Good morning, Yuhaya")
                .font(.largeTitle.bold()).foregroundStyle(AppColor.ink)
        }
        .padding(.top, 12)
    }

    private var progressCard: some View {
        VStack(alignment: .leading, spacing: 18) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 5) {
                    Text("This week").font(.headline)
                    Text("Keep your teaching rhythm going.").font(.subheadline).foregroundStyle(.secondary)
                }
                Spacer()
                Image(systemName: "chart.line.uptrend.xyaxis")
                    .font(.title2).foregroundStyle(AppColor.indigo)
                    .padding(10).background(AppColor.lavender, in: Circle())
            }
            HStack(spacing: 0) {
                Metric(value: "12", label: "Classes")
                Divider().frame(height: 38)
                Metric(value: "86", label: "Learners")
                Divider().frame(height: 38)
                Metric(value: "94%", label: "Attendance")
            }
        }
        .padding(20)
        .background(.background, in: RoundedRectangle(cornerRadius: 24, style: .continuous))
        .shadow(color: .black.opacity(0.06), radius: 14, y: 5)
    }

    private var learnerPreview: some View {
        HStack(spacing: 12) {
            Avatar(initials: "AR", color: .pink)
            VStack(alignment: .leading, spacing: 3) {
                Text("Alya Rahman").font(.headline)
                Text("Completed 8 of 10 activities").font(.subheadline).foregroundStyle(.secondary)
            }
            Spacer()
            Image(systemName: "chevron.right").font(.footnote.weight(.semibold)).foregroundStyle(.tertiary)
        }
        .padding(16)
        .background(.background, in: RoundedRectangle(cornerRadius: 18, style: .continuous))
    }
}

private struct ClassesView: View {
    var body: some View {
        NavigationStack {
            List {
                Section("Active classes") {
                    ClassListRow(title: "Visual Design Fundamentals", subtitle: "24 learners · Next: Today, 09:00", color: .orange)
                    ClassListRow(title: "Product Strategy", subtitle: "18 learners · Next: Today, 13:30", color: AppColor.indigo)
                    ClassListRow(title: "Creative Coding", subtitle: "16 learners · Next: Fri, 10:00", color: .teal)
                }
                Section("Drafts") {
                    ClassListRow(title: "Portfolio Workshop", subtitle: "8 learners · Not published", color: .gray)
                }
            }
            .navigationTitle("Classes")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button { } label: { Image(systemName: "plus") }
                    .accessibilityLabel("Create class")
                }
            }
        }
    }
}

private struct LearnersView: View {
    @State private var query = ""
    private let learners = [
        ("Alya Rahman", "Visual Design Fundamentals", "AR", Color.pink),
        ("Bima Santoso", "Product Strategy", "BS", Color.blue),
        ("Citra Maheswari", "Creative Coding", "CM", Color.orange),
        ("Dimas Pratama", "Visual Design Fundamentals", "DP", Color.teal)
    ]

    var body: some View {
        NavigationStack {
            List {
                Section("86 learners") {
                    ForEach(filteredLearners, id: \.0) { learner in
                        HStack(spacing: 12) {
                            Avatar(initials: learner.2, color: learner.3)
                            VStack(alignment: .leading, spacing: 3) {
                                Text(learner.0).font(.headline)
                                Text(learner.1).font(.subheadline).foregroundStyle(.secondary)
                            }
                            Spacer()
                            Image(systemName: "chevron.right").font(.footnote.weight(.semibold)).foregroundStyle(.tertiary)
                        }
                        .padding(.vertical, 3)
                    }
                }
            }
            .navigationTitle("Learners")
            .searchable(text: $query, prompt: "Search learners")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button { } label: { Image(systemName: "person.badge.plus") }
                    .accessibilityLabel("Add learner")
                }
            }
        }
    }

    private var filteredLearners: [(String, String, String, Color)] {
        query.isEmpty ? learners : learners.filter { $0.0.localizedCaseInsensitiveContains(query) }
    }
}

private struct Metric: View {
    let value: String
    let label: String
    var body: some View {
        VStack(spacing: 3) {
            Text(value).font(.title3.bold()).foregroundStyle(AppColor.ink)
            Text(label).font(.caption).foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
    }
}

private struct ClassRow: View {
    let time: String; let title: String; let detail: String; let color: Color
    var body: some View {
        HStack(spacing: 14) {
            Text(time).font(.subheadline.weight(.bold)).foregroundStyle(color).frame(width: 46, alignment: .leading)
            Rectangle().fill(color).frame(width: 4).clipShape(Capsule())
            VStack(alignment: .leading, spacing: 3) {
                Text(title).font(.headline).foregroundStyle(AppColor.ink)
                Text(detail).font(.subheadline).foregroundStyle(.secondary)
            }
            Spacer(minLength: 0)
        }
        .padding(16)
        .background(.background, in: RoundedRectangle(cornerRadius: 18, style: .continuous))
    }
}

private struct ClassListRow: View {
    let title: String; let subtitle: String; let color: Color
    var body: some View {
        HStack(spacing: 13) {
            Image(systemName: "book.closed.fill").foregroundStyle(color)
                .frame(width: 38, height: 38).background(color.opacity(0.14), in: RoundedRectangle(cornerRadius: 10, style: .continuous))
            VStack(alignment: .leading, spacing: 3) {
                Text(title).font(.headline)
                Text(subtitle).font(.subheadline).foregroundStyle(.secondary)
            }
        }
        .padding(.vertical, 3)
    }
}

private struct Avatar: View {
    let initials: String; let color: Color
    var body: some View {
        Text(initials).font(.caption.weight(.bold)).foregroundStyle(color)
            .frame(width: 40, height: 40).background(color.opacity(0.15), in: Circle())
    }
}

private func sectionTitle(_ title: String, action: String) -> some View {
    HStack {
        Text(title).font(.title3.bold()).foregroundStyle(AppColor.ink)
        Spacer()
        Button(action) { }.font(.subheadline.weight(.semibold))
    }
}

#Preview {
    ContentView()
}
