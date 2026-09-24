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

enum AppColor {
    static let indigo = Color(red: 0.29, green: 0.30, blue: 0.82)
    static let lavender = Color(red: 0.94, green: 0.94, blue: 1.0)
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
