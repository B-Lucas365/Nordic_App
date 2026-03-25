//
//  TMDBModel.swift
//  Nordic
//
//  Created by Lucas Silva on 24/03/26.
//

import Foundation

struct TMDBMovieResponseDTO: Decodable {
    let results: [TMDBMovieDTO]
}

struct TMDBMovieDTO: Decodable, Identifiable {
    let id: Int
    let title: String
    let releaseDate: String?
    let voteAverage: Double
    let posterPath: String?
    let backdropPath: String?
    
    enum CodingKeys: String, CodingKey {
        case id, title
        
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
    }
}
