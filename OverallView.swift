//
//  OverallView.swift
//  Footchecker
//
//  Created by 田诗韵 on 11/18/23.
//

import SwiftUI



struct OverallView: View {
    @State private var selectedTab = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            MainView()
                .tabItem {
                    Label("Main", systemImage: "house.fill")
                }
                .tag(0)

            MeView()
                .tabItem {
                    Label("Me", systemImage: "person.fill")
                }
                .tag(1)

            ActivityView()
                .tabItem {
                    Label("Activity", systemImage: "bell.fill")
                }
                .tag(2)
        }
        .accentColor(.purple) // Change the tint color of the selected tab
    }
}








#Preview {
    OverallView()
}
