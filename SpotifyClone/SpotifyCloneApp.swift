//
//  SpotifyCloneApp.swift
//  SpotifyClone
//
//  Created by Vanya Mutafchieva on 08/10/2024.
//

import SwiftUI
import SwiftfulRouting

@main
struct SpotifyCloneApp: App {
    var body: some Scene {
        WindowGroup {
            RouterView { _ in
                HomeView()
            }
            
        }
    }
}
