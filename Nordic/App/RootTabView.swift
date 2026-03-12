//
//  RootTabView.swift
//  Nordic
//
//  Created by Lucas Renan on 10/02/26.
//

import SwiftUI

enum AppTab: Hashable {
    case home, search, profile, favorites
}

struct RootTabView: View {
    @State private var selection: AppTab = .home
    
    var body: some View {
        TabView(selection: $selection) {
            Tab("Home", systemImage: "house", value: .home) {
                HomeView()
            }
            
            Tab("Search", systemImage: "magnifyingglass", value: .search) {
                SearchView()
            }
            
            Tab("Favorites", systemImage: "heart", value: .favorites) {
                FavoritesView()
            }
            
            Tab("Profile", systemImage: "person", value: .profile) {
                ProfileView()
            }
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    RootTabView()
        .environmentObject(FavoritesStore())
}
