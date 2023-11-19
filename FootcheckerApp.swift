//
//  FootcheckerApp.swift
//  Footchecker
//
//  Created by 田诗韵 on 11/18/23.
//

import SwiftUI

@main
struct FootcheckerApp: App {
    let persistenceController = PersistenceController.shared
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
