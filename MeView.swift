//
//  MeView.swift
//  Footchecker
//
//  Created by 田诗韵 on 11/18/23.
//


import SwiftUI

struct MeView: View {
    var body: some View {
        NavigationView {
            List {
                Section {
                    Button("Logout") {
                        LoginView()
                    }
                }

                Section(header: Text("Information")) {
                    NavigationLink(destination: HelpView()) {
                        Text("Help")
                    }
                    NavigationLink(destination: AboutView()) {
                        Text("About")
                    }
                }
            }
            .navigationTitle("Settings")
        }
    }
}

struct HelpView: View {
    var body: some View {
        Text("Help Information")
        // Add more content or layout for Help view
    }
}

struct AboutView: View {
    var body: some View {
        Text("About Information")
        // Add more content or layout for About view
    }
}

// For Preview
struct MeView_Previews: PreviewProvider {
    static var previews: some View {
        MeView()
    }
}

