import SwiftUI

struct SessionDetailView: View {
    private let learners = [
        ("Alya Rahman", "AR", Color.pink),
        ("Bima Santoso", "BS", Color.blue),
        ("Citra Maheswari", "CM", Color.orange),
        ("Dimas Pratama", "DP", Color.teal)
    ]

    var body: some View {
        List {
            Section {
                overviewCard
                    .listRowInsets(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
                    .listRowBackground(Color.clear)
            }

            Section("16 learners") {
                ForEach(learners, id: \.0) { learner in
                    NavigationLink {
                        EvidenceView(learnerName: learner.0, initials: learner.1, color: learner.2)
                    } label: {
                        HStack(spacing: 12) {
                            Avatar(initials: learner.1, color: learner.2)
                            VStack(alignment: .leading, spacing: 3) {
                                Text(learner.0).font(.headline)
                                Text("Web Development").font(.subheadline).foregroundStyle(.secondary)
                            }
                            Spacer()
                        }
                        .padding(.vertical, 3)
                    }
                }
            }
        }
        .listStyle(.insetGrouped)
        .navigationTitle("Responsive layouts")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button { } label: {
                    Image(systemName: "ellipsis.circle")
                }
                .accessibilityLabel("Session options")
            }
        }
    }

    private var overviewCard: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(alignment: .top) {
                Image(systemName: "rectangle.3.group.fill")
                    .font(.title2)
                    .foregroundStyle(AppColor.indigo)
                    .frame(width: 46, height: 46)
                    .background(AppColor.indigo.opacity(0.14), in: RoundedRectangle(cornerRadius: 13, style: .continuous))
                VStack(alignment: .leading, spacing: 4) {
                    Text("Responsive layouts").font(.headline)
                    Text("Web Development · Session 4 of 8")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                Spacer()
            }

            Divider()

            HStack(spacing: 0) {
                SessionInfo(symbol: "calendar", title: "Tuesday", subtitle: "October 1")
                Divider().frame(height: 36)
                SessionInfo(symbol: "clock", title: "10:00", subtitle: "90 minutes")
                Divider().frame(height: 36)
                SessionInfo(symbol: "mappin.and.ellipse", title: "Lab 2", subtitle: "On campus")
            }
        }
        .padding(18)
        .background(.background, in: RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(color: .black.opacity(0.05), radius: 10, y: 4)
    }
}

private struct SessionInfo: View {
    let symbol: String
    let title: String
    let subtitle: String

    var body: some View {
        VStack(spacing: 4) {
            Image(systemName: symbol).font(.subheadline).foregroundStyle(AppColor.indigo)
            Text(title).font(.caption.weight(.semibold))
            Text(subtitle).font(.caption2).foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
    }
}
