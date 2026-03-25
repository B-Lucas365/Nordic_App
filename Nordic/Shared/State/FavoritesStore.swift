//
//  AppStore.swift
//  Nordic
//
//  Created by Lucas Silva on 26/02/26.
//

import Foundation
import Combine

final class FavoritesStore: ObservableObject {
    @Published private(set) var favoriteIds: Set<Int> = []
    @Published private(set) var watchlistIds: Set<Int> = []
    
    private var catalog: [Int: MediaItem] = [:]
    private let storeKey = "favorite_store_key"
    
    init() {
        loadPersistedState()
    }
    
    func register(_ items: [MediaItem]) {
        for item in items {
            catalog[item.id] = item
        }
    }
    
    func isFavorite(_ item: MediaItem) -> Bool {
        favoriteIds.contains(item.id)
    }
    
    func toggleFavorite(_ item: MediaItem) {
        register([item])
        
        if favoriteIds.contains(item.id) {
            favoriteIds.remove(item.id)
        } else {
            favoriteIds.insert(item.id)
        }
        
        persistState()
    }
    
    var favoriteItems: [MediaItem] {
        favoriteIds
            .compactMap {catalog[$0]}
            .sorted {$0.title < $1.title}
    }
    
    func isInWatchList(_ item: MediaItem) -> Bool {
        watchlistIds.contains(item.id)
    }
    
    func toggleWatchList(_ item: MediaItem) {
        register([item])
        
        if watchlistIds.contains(item.id) {
            watchlistIds.remove(item.id)
        } else {
            watchlistIds.insert(item.id)
        }
        
        persistState()
    }
    
    var watchListItems: [MediaItem] {
        watchlistIds
            .compactMap {catalog[$0]}
            .sorted {$0.title < $1.title}
    }
    
    private func persistState() {
        let state = FavoritesPersistenceState(
            favoritesIds: Array(favoriteIds),
            watchListIds: Array(watchlistIds)
        )
        
        do {
            let data = try JSONEncoder().encode(state)
            UserDefaults.standard.set(data, forKey: storeKey)
        } catch {
            print("Failed to persist Favorites state")
        }
    }
    
   
    private func loadPersistedState() {
        guard let data = UserDefaults.standard.data(forKey: storeKey) else {
            return
        }
        
        do {
            let state = try JSONDecoder().decode(FavoritesPersistenceState.self, from: data)
            favoriteIds = Set(state.favoritesIds)
            watchlistIds = Set(state.watchListIds)
        } catch {
            print("Failed to load persisted favorites state", error)
        }
    }
}

