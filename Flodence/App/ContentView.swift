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
        .tint(AppColor.primary)
    }
}

enum AppColor {
    static let primary = Color(red: 159.0 / 255.0, green: 102.0 / 255.0, blue: 175.0 / 255.0)
    static let indigo = primary
    static let lavender = Color(red: 0.97, green: 0.92, blue: 0.98)
    static let ink = Color(red: 0.10, green: 0.11, blue: 0.18)
}

struct Avatar: View {
    let initials: String; let color: Color
    var body: some View {
        Text(initials).font(.caption.weight(.bold)).foregroundStyle(color)
            .frame(width: 40, height: 40).background(color.opacity(0.15), in: Circle())
    }
}


#Preview {
    ContentView()
}
