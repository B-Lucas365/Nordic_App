//
//  HomeView.swift
//  Nordic
//
//  Created by Lucas Renan on 10/02/26.
//
import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var favoritesStore: FavoritesStore
    @State private var searchText = ""
    @State private var selectedGenreId: Int = 0
    @State private var selectedSection: HomeSection? = nil
    
    private let genres: [Genre] = [
        Genre(id: 0, name: "All"),
        Genre(id: 1, name: "Adventure"),
        Genre(id: 2, name: "Comedy"),
        Genre(id: 3, name: "Fantasy"),
        Genre(id: 4, name: "Drama")
    ]
    
    private let heroItems: [MediaItem] = [
        MediaItem(id: 1, title: "The Beekeeper", year: "2025", rating: 7.6),
        MediaItem(id: 2, title: "Dune: Part Two", year: "2024", rating: 8.4),
        MediaItem(id: 3, title: "Inside Out 2", year: "2024", rating: 7.9)
    ]
    
    private let newItems: [MediaItem] = [
        MediaItem(id: 11, title: "Lilo & Stitch", year: "2025", rating: 7.2),
        MediaItem(id: 12, title: "House of David", year: "2025", rating: 7.8),
        MediaItem(id: 13, title: "Mickey 17", year: "2025", rating: 6.9),
        MediaItem(id: 14, title: "Another Title", year: "2024", rating: 7.1)
    ]
    
    private func items(for section: HomeSection) -> [MediaItem] {
        switch section {
        case .new: return newItems
        case .movies: return newItems
        }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("AppBackground").ignoresSafeArea()
                ScrollView {
                    VStack(alignment: .leading, spacing: 18) {
                        HStack {
                            Text("Discover")
                                .font(.system(size: 28, weight: .bold))
                                .foregroundStyle(Color("AppTextPrimary"))
                            Spacer()
                        }
                        .padding(.top, 6)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 10) {
                                ForEach(genres) {genre in
                                    GenreChipView(
                                        title: genre.name, isSelected: selectedGenreId == genre.id
                                    ) {
                                        selectedGenreId = genre.id
                                    }
                                }
                            }
                            .padding(.horizontal, 2)
                        }
                        
                        TabView {
                            ForEach(heroItems) {item in
                                HeroBannerView(title: item.title)
                                    .padding(.horizontal, 2)
                            }
                        }
                        .frame(height: 190)
                        .tabViewStyle(.page(indexDisplayMode: .automatic))

                        SectionHeaderView(title: "New") {
                            selectedSection = .new
                        }
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 14) {
                                ForEach(newItems) {item in
                                    NavigationLink(value: item) {
                                        PosterCardView(item: item)
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                        }
                        
                        Spacer()
                    }
                    .padding(.horizontal, 18)
                    .padding(.bottom, 20)
                    .navigationTitle("")
                    .toolbarVisibility(.hidden)
                   
                }
            }
            .onAppear {
                favoritesStore.register(heroItems)
                favoritesStore.register(newItems)
            }
            .navigationDestination(for: MediaItem.self) { item in
                    DetailView(item: item)
            }
            .navigationDestination(item: $selectedSection) {section in
                SeeAllView(title: section.title, items: items(for: section))
            }
        }
    }
        
}

private struct HeroBannerView: View {
    let title: String
    var body: some View {
        RoundedRectangle(cornerRadius: 24, style: . continuous)
            .fill(Color.white.opacity(0.10))
            .overlay(
                HStack {
                    Text(title)
                        .font(.system(size: 20, weight: .bold))
                        .foregroundStyle(Color("AppTextPrimary"))
                        .padding()
                    Spacer()
                }
            )
    }
}
