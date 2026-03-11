//
//  SearchFilters.swift
//  Nordic
//
//  Created by Lucas Silva on 23/02/26.
//

import Foundation

struct SearchFilters: Equatable {
    var mediaType: MediaType = .all
    var selectedGenreIds: Set<Int> = []
    var minimunRating: Double = 0
}
