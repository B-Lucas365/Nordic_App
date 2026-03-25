//
//  FavotitesPersistenceState.swift
//  Nordic
//
//  Created by Lucas Silva on 19/03/26.
//
import Foundation

struct FavoritesPersistenceState: Codable {
    let favoritesIds: [Int]
    let watchListIds: [Int]
}

