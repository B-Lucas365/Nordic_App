//
//  TMDBClient.swift
//  Nordic
//
//  Created by Lucas Silva on 24/03/26.
//

import Foundation

enum TMDBClientError: Error {
    case invalidURL
    case invalidResponse
}

final class TMDBClient {
    func fethTrendingMovie() async throws -> [TMDBMovieDTO] {
        guard var components = URLComponents(string: TMDBConfig.baseURL) else {
            throw TMDBClientError.invalidURL
        }
        components.path = "/3/trending/movie/day"
        components.queryItems = [
            URLQueryItem(name: "language", value: "pt-BR")
        ]
        
        guard let url = components.url else {
            throw TMDBClientError.invalidURL
        }
        
        return try await fetchMovies(from: url)
        
    }
    
    func fetchPopularMovie() async throws -> [TMDBMovieDTO] {
        guard var components = URLComponents(string: TMDBConfig.baseURL) else {
            throw TMDBClientError.invalidURL
        }
        
        components.path = "/3/movie/popular"
        components.queryItems = [
            URLQueryItem(name: "language", value: "pt-BR"),
            URLQueryItem(name: "page", value: "1")
        ]
        
        guard let url = components.url else {
            throw TMDBClientError.invalidURL
        }
        
        return try await fetchMovies(from: url)
    }
    
    
    private func fetchMovies(from url: URL) async throws -> [TMDBMovieDTO] {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "accept")
        request.setValue("Bearer \(TMDBConfig.bearerToken)", forHTTPHeaderField: "Authorization")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw TMDBClientError.invalidURL
        }
        
        guard (200..<300).contains(httpResponse.statusCode) else {
            throw TMDBClientError.invalidResponse
        }
        
        let decoded = try JSONDecoder().decode(TMDBMovieResponseDTO.self, from: data)
        return decoded.results
        
    }
    
}
