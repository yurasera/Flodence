import SwiftUI

struct DashboardView: View {
    private let activeClasses = [
        ClassSummary(title: "Desain Grafis", subtitle: "24 learners · Today, 08:00", color: .orange),
        ClassSummary(title: "Coding Games", subtitle: "18 learners · Today, 10:00", color: AppColor.primary),
        ClassSummary(title: "Web Development", subtitle: "16 learners · Fri, 10:00", color: .teal),
        ClassSummary(title: "Mobile Development", subtitle: "8 learners · Fri, 13:00", color: .blue),
        ClassSummary(title: "UI/UX Design", subtitle: "20 learners · Mon, 09:00", color: .pink),
        ClassSummary(title: "Artificial Intelligence", subtitle: "14 learners · Mon, 11:00", color: .purple),
        ClassSummary(title: "Data Science", subtitle: "17 learners · Tue, 08:00", color: .indigo),
        ClassSummary(title: "Robotics", subtitle: "12 learners · Tue, 10:00", color: .red),
        ClassSummary(title: "English Club", subtitle: "22 learners · Wed, 09:00", color: .mint),
        ClassSummary(title: "Mathematics", subtitle: "26 learners · Wed, 11:00", color: .cyan),
        ClassSummary(title: "Physics Lab", subtitle: "15 learners · Thu, 08:00", color: .yellow),
        ClassSummary(title: "Digital Marketing", subtitle: "19 learners · Thu, 13:00", color: .green)
    ]

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    header
                    progressCard
                    Section {
                        LazyVGrid(
                            columns: [GridItem(.flexible(), spacing: 12), GridItem(.flexible(), spacing: 12)],
                            spacing: 12
                        ) {
                            ForEach(activeClasses) { classItem in
                                NavigationLink {
                                    ClassDetailView()
                                } label: {
                                    ClassListRow(title: classItem.title, subtitle: classItem.subtitle, color: classItem.color)
                                }
                                .buttonStyle(.plain)
                            }
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
        HStack(spacing: 14) {
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(width: 96, height: 96)
                .accessibilityHidden(true)

            VStack(alignment: .leading, spacing: 18) {
                VStack(alignment: .leading, spacing: 3) {
                    Text("This week").font(.headline)
                    Text("Keep your teaching rhythm going.")
                        .font(.caption)
                        .foregroundStyle(.white.opacity(0.78))
                }
                HStack(spacing: 0) {
                    Metric(value: "12", label: "Classes", isOnPrimary: true)
                    Rectangle().fill(.white.opacity(0.32)).frame(width: 1, height: 38)
                    Metric(value: "86", label: "Learners", isOnPrimary: true)
                    Rectangle().fill(.white.opacity(0.32)).frame(width: 1, height: 38)
                    Metric(value: "94%", label: "Attendance", isOnPrimary: true)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(20)
        .foregroundStyle(.white)
        .background(
            LinearGradient(
                colors: [Color(red: 0.27, green: 0.10, blue: 0.33), AppColor.primary],
                startPoint: .bottomTrailing,
                endPoint: .topLeading
            ),
            in: RoundedRectangle(cornerRadius: 24, style: .continuous)
        )
        .shadow(color: AppColor.primary.opacity(0.26), radius: 14, y: 5)
    }
}

private struct Metric: View { let value: String; let label: String; var isOnPrimary = false; var body: some View { VStack(spacing: 3) { Text(value).font(.title3.bold()).foregroundStyle(isOnPrimary ? .white : AppColor.ink); Text(label).font(.caption).minimumScaleFactor(0.7).lineLimit(1).foregroundStyle(isOnPrimary ? .white.opacity(0.78) : .secondary) }.frame(maxWidth: .infinity) } }
private struct ClassSummary: Identifiable { let id = UUID(); let title: String; let subtitle: String; let color: Color }
private struct ClassRow: View { let time: String; let title: String; let detail: String; let color: Color; var body: some View { HStack(spacing: 14) { Text(time).font(.subheadline.weight(.bold)).foregroundStyle(color).frame(width: 46, alignment: .leading); Rectangle().fill(color).frame(width: 4).clipShape(Capsule()); VStack(alignment: .leading, spacing: 3) { Text(title).font(.headline).foregroundStyle(AppColor.ink); Text(detail).font(.subheadline).foregroundStyle(.secondary) }; Spacer(minLength: 0) }.padding(16).background(.background, in: RoundedRectangle(cornerRadius: 18, style: .continuous)) } }
private func sectionTitle(_ title: String, action: String) -> some View { HStack { Text(title).font(.title3.bold()).foregroundStyle(AppColor.ink); Spacer(); Button(action) { }.font(.subheadline.weight(.semibold)) } }
private struct ClassListRow: View {
    let title: String; let subtitle: String; let color: Color;
    var body: some View { VStack(alignment: .leading, spacing: 14) { Image(systemName: "book.closed.fill").foregroundStyle(color).frame(width: 38, height: 38).background(color.opacity(0.18), in: RoundedRectangle(cornerRadius: 10, style: .continuous)); Spacer(minLength: 4); Text(title).font(.headline).lineLimit(2).frame(maxWidth: .infinity, alignment: .leading); Text(subtitle).font(.caption).foregroundStyle(.secondary).lineLimit(2).frame(maxWidth: .infinity, alignment: .leading) }.padding(16).frame(maxWidth: .infinity, minHeight: 160, alignment: .leading).background(.white, in: RoundedRectangle(cornerRadius: 18, style: .continuous)) }
}
