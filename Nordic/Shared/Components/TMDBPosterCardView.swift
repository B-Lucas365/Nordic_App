//
//  TMDBPosterCardView.swift
//  Nordic
//
//  Created by Lucas Silva on 24/03/26.
//

import SwiftUI

struct TMDBPosterCardView: View {
    let movie: TMDBMovieDTO
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            AsyncImage(url: posterURL) {phase in
                switch phase {
                case .empty:
                    RoundedRectangle(cornerRadius: 18, style: .continuous)
                        .fill(Color.white.opacity(0.12))
                        .frame(width: 140, height: 200)
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 140, height: 200)
                        .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
                case .failure:
                    RoundedRectangle(cornerRadius: 18, style: .continuous)
                        .fill(Color.white.opacity(0.12))
                        .frame(width: 140, height: 200)
                        .overlay(
                            Image(systemName: "photo")
                                .foregroundStyle(Color("AppSecondary"))
                        )
                    @unknown default:
                    EmptyView()
                }
            }
            
            Text(movie.title)
                .font(.system(size: 14, weight: .semibold))
                .foregroundStyle(Color("AppTextPrimary"))
                .lineLimit(1)
            
            HStack(spacing: 8) {
                Text(releaseYear)
                    .font(.system(size: 12))
                    .foregroundStyle(Color("AppSecondary"))
                
                Text("•")
                    .foregroundStyle(Color("AppSecondary"))
                Image(systemName: "star.fill")
                    .font(.system(size: 12))
                    .foregroundStyle(Color.yellow)
                
                Text(String(format: "%.1f", movie.voteAverage))
                    .font(.system(size: 12, weight: .medium))
                    .foregroundStyle(Color("AppTextPrimary"))
            }
        }
    }
    
    private var posterURL: URL? {
        guard let posterPath = movie.posterPath else {
            return nil
        }
        return URL(string: "\(TMDBConfig.imageBaseURL)\(posterPath)")
    }
    
    private var releaseYear: String {
        guard let releaseDate = movie.releaseDate, releaseDate.count >= 4 else {
            return "_"
        }
        
        return String(releaseDate.prefix(4))
    }
    
}
