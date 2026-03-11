//
//  NordicApp.swift
//  Nordic
//
//  Created by Lucas Renan on 10/02/26.
//

import SwiftUI

@main
struct NordicApp: App {
    @StateObject private var favoritesStore = FavoritesStore()
    
    var body: some Scene {
        WindowGroup {
            RootTabView()
                .environmentObject(favoritesStore)
        }
    }
}
