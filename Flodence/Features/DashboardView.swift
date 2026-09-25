import SwiftUI

struct DashboardView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    header
                    progressCard
                    Section {
                        ClassListRow(title: "Desain Grafis", subtitle: "24 learners · Next: Today, 08:00", color: .orange)
                        ClassListRow(title: "Coding Games", subtitle: "18 learners · Next: Today, 10:00", color: AppColor.indigo)
                        NavigationLink {
                            ClassDetailView()
                        } label: {
                            ClassListRow(title: "Web Development", subtitle: "16 learners · Next: Fri, 10:00", color: .teal)
                        }
                    } header: {
                        HStack {
                            Text("Active classes").font(.title3.bold()).foregroundStyle(AppColor.ink)
                            Spacer()
                            Button { } label: {
                                Image(systemName: "plus")
                                    .font(.subheadline.weight(.bold))
                                    .foregroundStyle(.white)
                                    .frame(width: 32, height: 32)
                                    .background(.black, in: Circle())
                            }
                            .accessibilityLabel("Add class")
                        }
                    }
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
                VStack(alignment: .leading, spacing: 5) { Text("This week").font(.headline); Text("Keep your teaching rhythm going.").font(.subheadline).foregroundStyle(.white.opacity(0.78)) }
                Spacer()
                Image(systemName: "chart.line.uptrend.xyaxis").font(.title2).foregroundStyle(AppColor.primary).padding(10).background(.white, in: Circle())
            }
            HStack(spacing: 0) { Metric(value: "12", label: "Classes", isOnPrimary: true); Rectangle().fill(.white.opacity(0.32)).frame(width: 1, height: 38); Metric(value: "86", label: "Learners", isOnPrimary: true); Rectangle().fill(.white.opacity(0.32)).frame(width: 1, height: 38); Metric(value: "94%", label: "Attendance", isOnPrimary: true) }
        }.padding(20).foregroundStyle(.white).background(AppColor.primary, in: RoundedRectangle(cornerRadius: 24, style: .continuous)).shadow(color: AppColor.primary.opacity(0.22), radius: 14, y: 5)
    }
}

private struct Metric: View { let value: String; let label: String; var isOnPrimary = false; var body: some View { VStack(spacing: 3) { Text(value).font(.title3.bold()).foregroundStyle(isOnPrimary ? .white : AppColor.ink); Text(label).font(.caption).foregroundStyle(isOnPrimary ? .white.opacity(0.78) : .secondary) }.frame(maxWidth: .infinity) } }
private struct ClassRow: View { let time: String; let title: String; let detail: String; let color: Color; var body: some View { HStack(spacing: 14) { Text(time).font(.subheadline.weight(.bold)).foregroundStyle(color).frame(width: 46, alignment: .leading); Rectangle().fill(color).frame(width: 4).clipShape(Capsule()); VStack(alignment: .leading, spacing: 3) { Text(title).font(.headline).foregroundStyle(AppColor.ink); Text(detail).font(.subheadline).foregroundStyle(.secondary) }; Spacer(minLength: 0) }.padding(16).background(.background, in: RoundedRectangle(cornerRadius: 18, style: .continuous)) } }
private func sectionTitle(_ title: String, action: String) -> some View { HStack { Text(title).font(.title3.bold()).foregroundStyle(AppColor.ink); Spacer(); Button(action) { }.font(.subheadline.weight(.semibold)) } }
private struct ClassListRow: View {
    let title: String; let subtitle: String; let color: Color;
    var body: some View { HStack(spacing: 13) { Image(systemName: "book.closed.fill").foregroundStyle(color).frame(width: 38, height: 38).background(color.opacity(0.18), in: RoundedRectangle(cornerRadius: 10, style: .continuous)); VStack(alignment: .leading, spacing: 3) { Text(title).font(.headline);
        Text(subtitle).font(.subheadline) };
        Spacer(minLength: 0) }.padding(16).frame(maxWidth: .infinity, alignment: .leading).background(.white, in: RoundedRectangle(cornerRadius: 18, style: .continuous)) }
}
