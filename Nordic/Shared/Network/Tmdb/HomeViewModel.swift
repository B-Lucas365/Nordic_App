//
//  HomeViewModel.swift
//  Nordic
//
//  Created by Lucas Silva on 24/03/26.
//

import Foundation
import Combine

@MainActor
final class HomeViewModel: ObservableObject {
    @Published var trendingMovies: [TMDBMovieDTO] = []
    @Published var popularMovies: [TMDBMovieDTO] = []
    @Published var isLoading = false
    @Published var errorMesage: String?
    
    private let client = TMDBClient()
    
    func load() async {
        isLoading = true
        errorMesage = nil
        
        do {
            async let trending = client.fethTrendingMovie()
            async let popular = client.fetchPopularMovie()
            
            trendingMovies = try await trending
            popularMovies = try await popular
            
        } catch {
            errorMesage = error.localizedDescription
        }
        
        isLoading = false
    }
}
