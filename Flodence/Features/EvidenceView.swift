import SwiftUI

struct EvidenceView: View {
    let learnerName: String
    let initials: String
    let color: Color
    @State private var isPresentingAddEvidence = false

    var body: some View {
        List {
            Section {
                HStack(spacing: 12) {
                    Avatar(initials: initials, color: .white)
                    VStack(alignment: .leading, spacing: 3) {
                        Text(learnerName).font(.headline)
                        Text("Web Development · Responsive layouts")
                            .font(.subheadline)
                            .foregroundStyle(.white.opacity(0.78))
                    }
                }
                .foregroundStyle(.white)
                .padding(16)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(AppColor.primary, in: RoundedRectangle(cornerRadius: 18, style: .continuous))
                .shadow(color: AppColor.primary.opacity(0.18), radius: 8, y: 3)
                .listRowInsets(EdgeInsets(top: 12, leading: 16, bottom: 8, trailing: 16))
                .listRowBackground(Color.clear)
            }

            Section("Evidence") {
                ObserveNoteCard()
                    .listRowInsets(cardInsets)
                LearnerResponseCard()
                    .listRowInsets(cardInsets)
                DifficultyCard()
                    .listRowInsets(cardInsets)
                PerformanceCard()
                    .listRowInsets(cardInsets)
                ProgressCard()
                    .listRowInsets(cardInsets)
            }
            .listRowSeparator(.hidden)
            .listRowBackground(Color.clear)
        }
        .listStyle(.insetGrouped)
        .navigationTitle("Evidence")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    isPresentingAddEvidence = true
                } label: {
                    Image(systemName: "plus")
                }
                .accessibilityLabel("Add evidence")
            }
        }
        .sheet(isPresented: $isPresentingAddEvidence) {
            AddEvidenceView(learnerName: learnerName)
        }
    }

    private var cardInsets: EdgeInsets {
        EdgeInsets(top: 6, leading: 16, bottom: 6, trailing: 16)
    }
}

private struct ObserveNoteCard: View {
    var body: some View {
        EvidenceCard(title: "Observe Note", symbol: "eye.fill", color: AppColor.primary) {
            EvidenceText(label: "Text Note", value: "Needed a reminder to check layout behaviour at smaller screen widths.")
        }
    }
}

private struct LearnerResponseCard: View {
    var body: some View {
        EvidenceCard(title: "Learner Response", symbol: "text.bubble.fill", color: AppColor.primary) {
            EvidenceText(label: "Question / Context", value: "How would the page layout change on a phone screen?")
            EvidenceText(label: "Learner Response", value: "I would stack the sections vertically and adjust the grid columns.")
        }
    }
}

private struct DifficultyCard: View {
    var body: some View {
        EvidenceCard(title: "Difficulty", symbol: "exclamationmark.circle.fill", color: AppColor.primary) {
            EvidenceText(label: "Difficulty Area", value: "Application", badgeColor: AppColor.primary)
            EvidenceText(label: "Text Note", value: "Understands the grid concept but still needs prompts to apply it in a responsive layout.")
        }
    }
}

private struct PerformanceCard: View {
    var body: some View {
        EvidenceCard(title: "Performance", symbol: "checkmark.circle.fill", color: AppColor.primary) {
            EvidenceText(label: "Task", value: "Build a responsive product landing page")
            EvidenceText(label: "Performance Status", value: "Partial", badgeColor: AppColor.primary)
            EvidenceText(label: "Text Note", value: "Completed the desktop layout and began adapting the navigation for mobile.")
        }
    }
}

private struct ProgressCard: View {
    var body: some View {
        EvidenceCard(title: "Progress", symbol: "chart.line.uptrend.xyaxis", color: AppColor.primary) {
            EvidenceText(label: "Previous State", value: "Guided")
            EvidenceText(label: "Current State", value: "Developing", badgeColor: AppColor.primary)
            EvidenceText(label: "Text Note", value: "Can now identify breakpoints with a brief prompt and is starting to make layout decisions independently.")
        }
    }
}

private struct EvidenceCard<Content: View>: View {
    let title: String
    let symbol: String
    let color: Color
    @ViewBuilder let content: Content

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            Label(title, systemImage: symbol)
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(color)
            content
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.background, in: RoundedRectangle(cornerRadius: 18, style: .continuous))
        .shadow(color: .black.opacity(0.05), radius: 8, y: 3)
    }
}

private struct EvidenceText: View {
    let label: String
    let value: String
    var badgeColor: Color? = nil

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(label).font(.caption.weight(.medium)).foregroundStyle(.secondary)
            if let badgeColor {
                Text(value)
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(badgeColor)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(badgeColor.opacity(0.14), in: Capsule())
            } else {
                Text(value).font(.subheadline).foregroundStyle(AppColor.ink)
            }
        }
    }
}

private struct AddEvidenceView: View {
    let learnerName: String
    @Environment(\.dismiss) private var dismiss
    @State private var questionContext = ""
    @State private var learnerResponse = ""
    @State private var difficultyArea: DifficultyArea = .concept
    @State private var note = ""
    @State private var observeNote = ""
    @State private var task = ""
    @State private var performanceStatus: PerformanceStatus = .notStarted
    @State private var performanceNote = ""
    @State private var previousState = ""
    @State private var currentState: ProgressState = .needsSupport
    @State private var progressNote = ""

    var body: some View {
        NavigationStack {
            Form {
                Section("Observe Note") {
                    TextField("Text Note", text: $observeNote, axis: .vertical)
                        .lineLimit(3...6)
                }

                Section("Learner Response") {
                    TextField("Question / Context", text: $questionContext, axis: .vertical)
                        .lineLimit(3...6)
                    TextField("Learner Response", text: $learnerResponse, axis: .vertical)
                        .lineLimit(3...6)
                }

                Section("Difficulty") {
                    Picker("Difficulty Area", selection: $difficultyArea) {
                        ForEach(DifficultyArea.allCases) { area in
                            Text(area.rawValue).tag(area)
                        }
                    }
                    Text(difficultyArea.description)
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                    TextField("Text Note", text: $note, axis: .vertical)
                        .lineLimit(3...6)
                }

                Section("Performance") {
                    TextField("Task", text: $task)
                    Picker("Performance Status", selection: $performanceStatus) {
                        ForEach(PerformanceStatus.allCases) { status in
                            Text(status.rawValue).tag(status)
                        }
                    }
                    Text(performanceStatus.description)
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                    TextField("Text Note", text: $performanceNote, axis: .vertical)
                        .lineLimit(3...6)
                }

                Section("Progress") {
                    TextField("Previous State", text: $previousState)
                    Picker("Current State", selection: $currentState) {
                        ForEach(ProgressState.allCases) { state in
                            Text(state.rawValue).tag(state)
                        }
                    }
                    TextField("Text Note", text: $progressNote, axis: .vertical)
                        .lineLimit(3...6)
                }
            }
            .navigationTitle("Add Evidence")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") { dismiss() }
                }
            }
        }
    }
}

private enum DifficultyArea: String, CaseIterable, Identifiable {
    case concept = "Concept"
    case application = "Application"
    case problemSolving = "Problem Solving"
    case reasoning = "Reasoning"
    case technicalSkill = "Technical Skill"
    case communication = "Communication"
    case other = "Other"

    var id: Self { self }

    var description: String {
        switch self {
        case .concept: "Kesulitan memahami konsep"
        case .application: "Kesulitan menerapkan konsep"
        case .problemSolving: "Kesulitan menyelesaikan masalah"
        case .reasoning: "Kesulitan menjelaskan alasan/logic"
        case .technicalSkill: "Kesulitan menggunakan tools, syntax, atau teknik"
        case .communication: "Kesulitan menjelaskan atau menyampaikan pemahaman"
        case .other: "Area kesulitan lainnya"
        }
    }
}

private enum PerformanceStatus: String, CaseIterable, Identifiable {
    case notStarted = "Not Started"
    case attempted = "Attempted"
    case partial = "Partial"
    case completed = "Completed"
    case independent = "Independent"

    var id: Self { self }

    var description: String {
        switch self {
        case .notStarted: "Belum mencoba"
        case .attempted: "Sudah mencoba"
        case .partial: "Sebagian berhasil"
        case .completed: "Tugas selesai"
        case .independent: "Dapat menyelesaikan tanpa bantuan"
        }
    }
}

private enum ProgressState: String, CaseIterable, Identifiable {
    case needsSupport = "Needs Support"
    case guided = "Guided"
    case developing = "Developing"
    case independent = "Independent"

    var id: Self { self }
}
