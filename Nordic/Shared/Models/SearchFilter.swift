//
//  SearchFilter.swift
//  Nordic
//
//  Created by Lucas Silva on 19/02/26.
//

import Foundation

enum SortOption: String, CaseIterable, Identifiable {
    case popularity = "Popularity"
    case ratingDesc = "Rating"
    case yearDesc = "Year"
    
    var id: String {rawValue}
}

struct SearchFilter: Equatable, Hashable {
    var selectecGenreId: Int? = nil
    var minRating: Double = 0.0
    var year: Int? = nil
    var sort: SortOption = .popularity
}

