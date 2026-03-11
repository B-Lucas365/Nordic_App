//
//  HomeSection.swift
//  Nordic
//
//  Created by Lucas Silva on 25/02/26.
//

import Foundation

enum HomeSection: String, Hashable, Identifiable {
    case new, movies
    
    var id: String {rawValue}
    var title: String {
        switch self {
        case .new: return "New"
        case .movies: return "Movies"
        }
    }
}
