//
//  Station_GamesApp.swift
//  Station-Games
//
//  Created by Dias Atudinov on 27.11.2024.
//

import SwiftUI

@main
struct Station_GamesApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            RootView()
                .preferredColorScheme(.light)
        }
    }
}
