//
//  MediaDetailView.swift
//  Nordic
//
//  Created by Lucas Renan on 11/02/26.
//

import SwiftUI

struct DetailView: View {
    @EnvironmentObject private var favoritesStore: FavoritesStore
    @Environment(\.dismiss) private var dismiss
    let item: MediaItem
    
    private let genres: [String] = ["Drama", "Sci-Fi", "Mystery"]
    private let overview: String =
    """
    Men and women live in a giant silo underground with several regulations which they believe are in place to protect them from the toxic and ruined world on the surface.
    """
    
    var body: some View {
        GeometryReader {geo in
            ZStack {
                Color("AppBackground").ignoresSafeArea()
                
                ScrollView(.vertical, showsIndicators: false) {
                    ZStack(alignment: .top) {
                        Rectangle()
                            .fill(Color.white.opacity(0.12))
                            .frame(height: 440)
                            .overlay(
                                Text("Poster / Backdrop")
                                    .foregroundStyle(Color("AppSecondary"))
                                    .font(.system(size: 14, weight: .medium))
                            )
                            .overlay(gradientOverlay, alignment: .bottom)

                        headerButtons
                            .padding(.top, geo.safeAreaInsets.top)
                            .padding(.horizontal, 18)
                    }
                    
                    content
                }
                .ignoresSafeArea(edges: .top)
            }
            .toolbar(.hidden, for: .navigationBar);
        }
    }
    
    private var gradientOverlay: some View {
        LinearGradient(
            colors: [
                .clear,
                Color("AppBackground").opacity(0.2),
                Color("AppBackground").opacity(0.85),
                Color("AppBackground"),
            ],
            startPoint: .top,
            endPoint: .bottom
        )
        .frame(height: 220)
    }
    
    private var headerButtons: some View {
        HStack {
            CircleIconButtom(systemImage: "chevron.left") {
                dismiss()
            }
            
            Spacer()
            
            HStack(spacing: 12) {
                CircleIconButtom(
                    systemImage: favoritesStore.isFavorite(item) ? "heart.fill" : "heart"
                ) {
                    favoritesStore.toggleFavorite(item)
                }
                
                CircleIconButtom (
                    systemImage: favoritesStore.isInWatchList(item) ? "bookmark.fill" : "bookmark"
                ) {
                    favoritesStore.toggleWatchList(item)
                }
            }
        }
    }
    
    private var content: some View {
        VStack(alignment: .leading,spacing: 18) {
            VStack(spacing: 6) {
                Text(item.title)
                    .font(.system(size: 34, weight: .bold))
                    .foregroundStyle(Color("AppTextPrimary"))
                
                Text(item.year)
                    .font(.system(size: 16, weight: .medium))
                
            }
            .frame(maxWidth: .infinity)
            .padding(.top, -28)
            
            HStack(spacing: 10) {
                ForEach(genres, id: \.self) {g in
                    Pill(text: g)
                }
                
                Spacer()

                RatingPill(rating: item.rating)
            }
            
            Text(overview)
                .font(.system(size: 15))
                .foregroundStyle(Color("AppSecondary"))
                .lineSpacing(4)

            HStack {
                Text("Cast")
                    .font(.system(size: 22, weight: .semibold))
                    .foregroundStyle(Color("AppTextPrimary"))

                Spacer()

                Button("See all") {
                    print("cast see all")
                }
                .font(.system(size: 14, weight: .medium))
                .foregroundStyle(Color("AppSecondary"))
            }

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 14) {
                    ForEach(0..<10, id: \.self) { i in
                        CastCard(name: "Actor \(i+1)")
                    }
                }
            }

            Spacer().frame(height: 24)
        }
        .padding(.horizontal, 18)
        .padding(.top, 14)
    }
}

