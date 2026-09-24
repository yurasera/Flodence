import SwiftUI

struct DashboardView: View {
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
                ToolbarItem(placement: .topBarLeading) { Text("YR").font(.title2.weight(.bold)).foregroundStyle(AppColor.ink) }
                ToolbarItem(placement: .topBarTrailing) {
                    Button { } label: { Image(systemName: "bell").font(.body.weight(.semibold)) }
                        .accessibilityLabel("Notifications")
                }
            }
        }
    }
    private var header: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Friday, September 25").font(.subheadline).foregroundStyle(.secondary)
            Text("Good morning, Yura").font(.largeTitle.bold()).foregroundStyle(AppColor.ink)
        }.padding(.top, 12)
    }
    private var progressCard: some View {
        VStack(alignment: .leading, spacing: 18) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 5) { Text("This week").font(.headline); Text("Keep your teaching rhythm going.").font(.subheadline).foregroundStyle(.secondary) }
                Spacer()
                Image(systemName: "chart.line.uptrend.xyaxis").font(.title2).foregroundStyle(AppColor.indigo).padding(10).background(AppColor.lavender, in: Circle())
            }
            HStack(spacing: 0) { Metric(value: "12", label: "Classes"); Divider().frame(height: 38); Metric(value: "86", label: "Learners"); Divider().frame(height: 38); Metric(value: "94%", label: "Attendance") }
        }.padding(20).background(.background, in: RoundedRectangle(cornerRadius: 24, style: .continuous)).shadow(color: .black.opacity(0.06), radius: 14, y: 5)
    }
    private var learnerPreview: some View {
        HStack(spacing: 12) { Avatar(initials: "AR", color: .pink); VStack(alignment: .leading, spacing: 3) { Text("Alya Rahman").font(.headline); Text("Completed 8 of 10 activities").font(.subheadline).foregroundStyle(.secondary) }; Spacer(); Image(systemName: "chevron.right").font(.footnote.weight(.semibold)).foregroundStyle(.tertiary) }
            .padding(16).background(.background, in: RoundedRectangle(cornerRadius: 18, style: .continuous))
    }
}

private struct Metric: View { let value: String; let label: String; var body: some View { VStack(spacing: 3) { Text(value).font(.title3.bold()).foregroundStyle(AppColor.ink); Text(label).font(.caption).foregroundStyle(.secondary) }.frame(maxWidth: .infinity) } }
private struct ClassRow: View { let time: String; let title: String; let detail: String; let color: Color; var body: some View { HStack(spacing: 14) { Text(time).font(.subheadline.weight(.bold)).foregroundStyle(color).frame(width: 46, alignment: .leading); Rectangle().fill(color).frame(width: 4).clipShape(Capsule()); VStack(alignment: .leading, spacing: 3) { Text(title).font(.headline).foregroundStyle(AppColor.ink); Text(detail).font(.subheadline).foregroundStyle(.secondary) }; Spacer(minLength: 0) }.padding(16).background(.background, in: RoundedRectangle(cornerRadius: 18, style: .continuous)) } }
private func sectionTitle(_ title: String, action: String) -> some View { HStack { Text(title).font(.title3.bold()).foregroundStyle(AppColor.ink); Spacer(); Button(action) { }.font(.subheadline.weight(.semibold)) } }
