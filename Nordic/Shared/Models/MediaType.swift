//
//  MediaType.swift
//  Nordic
//
//  Created by Lucas Silva on 23/02/26.
//

import Foundation

enum MediaType: String, CaseIterable, Identifiable {
    case all, movie, tv
    
    var id: Self {self}
    
    var title: String {
        switch self {
        case .all: return "All"
        case .movie: return "Movies"
        case .tv: return "TV"
        }
    }
}
