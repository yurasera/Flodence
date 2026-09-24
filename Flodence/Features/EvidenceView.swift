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
                    Avatar(initials: initials, color: color)
                    VStack(alignment: .leading, spacing: 3) {
                        Text(learnerName).font(.headline)
                        Text("Web Development · Responsive layouts")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                }
                .padding(.vertical, 3)
            }

            Section("Evidence") {
                EvidenceCard()
                    .listRowInsets(EdgeInsets(top: 10, leading: 16, bottom: 10, trailing: 16))
                    .listRowBackground(Color.clear)
            }
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
}

private struct EvidenceCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Label("Observe", systemImage: "eye.fill")
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(.teal)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .background(Color.teal.opacity(0.14), in: Capsule())
                Spacer()
                Text("Today").font(.caption).foregroundStyle(.secondary)
            }

            VStack(alignment: .leading, spacing: 6) {
                Text("Learner Response").font(.headline)
                Text("The learner identified the main layout regions, but needed guidance to make the grid adapt on smaller screens.")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            Divider()

            HStack(spacing: 8) {
                Image(systemName: "exclamationmark.circle.fill").foregroundStyle(.orange)
                Text("Application").font(.subheadline.weight(.medium))
                Spacer()
                Text("Difficulty").font(.caption).foregroundStyle(.secondary)
            }
        }
        .padding(16)
        .background(.background, in: RoundedRectangle(cornerRadius: 18, style: .continuous))
        .shadow(color: .black.opacity(0.05), radius: 8, y: 3)
    }
}

private struct AddEvidenceView: View {
    let learnerName: String
    @Environment(\.dismiss) private var dismiss
    @State private var questionContext = ""
    @State private var learnerResponse = ""
    @State private var difficultyArea: DifficultyArea = .concept
    @State private var note = ""

    var body: some View {
        NavigationStack {
            Form {
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
