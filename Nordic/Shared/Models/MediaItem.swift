//
//  MediaItem.swift
//  Nordic
//
//  Created by Lucas Renan on 10/02/26.
//

import Foundation

struct MediaItem: Identifiable, Hashable {
    let id: Int
    let title: String
    let year: String
    let rating: Double
    
    let genreIds: [Int]
    let type: MediaType
    
    init(
        id: Int,
        title: String,
        year: String,
        rating: Double,
        genreIds: [Int] = [],
        type: MediaType = .movie
    ) {
        self.id = id
        self.title = title
        self.year = year
        self.rating = rating
        self.genreIds = genreIds
        self.type = type
    }
}


