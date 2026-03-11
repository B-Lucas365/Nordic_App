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
    private var catalog: [Int: MediaItem] = [:]
    
    func register(_ items: [MediaItem]) {
        for item in items {
            catalog[item.id] = item
        }
    }
    
    func isFfavorite(_ item: MediaItem) -> Bool {
        favoriteIds.contains(item.id)
    }
    
    func toggleFavorite(_ item: MediaItem) {
        register([item])
        
        if favoriteIds.contains(item.id) {
            favoriteIds.remove(item.id)
        } else {
            favoriteIds.insert(item.id)
        }
    }
    
    var favoriteItems: [MediaItem] {
        favoriteIds
            .compactMap {catalog[$0]}
            .sorted {$0.title < $1.title}
    }
}

