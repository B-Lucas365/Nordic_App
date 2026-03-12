//
//  SearchView.swift
//  Nordic
//
//  Created by Lucas Renan on 10/02/26.
//

import SwiftUI

struct SearchView: View {
    @EnvironmentObject private var favoritesStore: FavoritesStore
    @State private var searchText = ""
    @State private var filters = SearchFilters()
    @State private var isShowingFilters = false

    private let genres: [Genre] = [
        .init(id: 1, name: "Adventure"),
        .init(id: 2, name: "Comedy"),
        .init(id: 3, name: "Fantasy"),
        .init(id: 4, name: "Drama"),
        .init(id: 5, name: "Sci-Fi"),
        .init(id: 6, name: "Mystery")
    ]

        // Mock de resultados (repare que agora tem type + genreIds)
    private let allItems: [MediaItem] = [
        .init(id: 101, title: "Silo", year: "2023", rating: 8.1, genreIds: [4,5,6], type: .tv),
        .init(id: 102, title: "Dune: Part Two", year: "2024", rating: 8.4, genreIds: [1,3,5], type: .movie),
        .init(id: 103, title: "The Beekeeper", year: "2025", rating: 7.6, genreIds: [1,4], type: .movie),
        .init(id: 104, title: "Only Murders", year: "2021", rating: 8.0, genreIds: [2,6], type: .tv),
        .init(id: 105, title: "Inside Out 2", year: "2024", rating: 7.9, genreIds: [2,3], type: .movie)
    ]
    
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.appBackground.ignoresSafeArea()
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 18) {
                        SearchBarView(text: $searchText) {
                            isShowingFilters = true
                        }
                        .padding(.top, 6)
                        
                        VStack(alignment: .leading, spacing: 14) {
                            ForEach(filteredItems) {item in
                                NavigationLink(value: item) {
                                    SearchResultRow(item: item)
                                }
                                .buttonStyle(.plain)
                            }
                            
                            if filteredItems.isEmpty {
                                Text("No Results")
                                    .foregroundStyle(Color.appSecondary)
                                    .padding(.top, 16)
                            }
                        }
                    }
                    .padding(.horizontal, 18)
                    .padding(.vertical, 16)
                }
            }
            .onAppear {
                favoritesStore.register(allItems)
            }
            .sheet(isPresented: $isShowingFilters) {
                FilterSheetView(filters: $filters, genres: genres)
            }
            .navigationDestination(for: MediaItem.self) {item in
                DetailView(item: item)
            }
            .toolbarVisibility(.hidden, for: .navigationBar)
        }
    }
    
    private var filteredItems: [MediaItem] {
        allItems.filter {item in
            let matchesText = searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
            || item.title.lowercased()
                .contains(searchText.lowercased())
            
            let matchesType = (filters.mediaType == .all) || (item.type == filters.mediaType)
            
            let matchesGenres = filters.selectedGenreIds.isEmpty || !filters.selectedGenreIds.isDisjoint(with: item.genreIds)
            
            let matchesRating = item.rating >= filters.minimunRating
            
            return matchesText && matchesType && matchesGenres && matchesRating
        }
    }
}

private struct SearchResultRow: View {
    let item: MediaItem

    var body: some View {
        HStack(spacing: 14) {
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .fill(Color.white.opacity(0.12))
                .frame(width: 68, height: 88)

            VStack(alignment: .leading, spacing: 8) {
                Text(item.title)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(Color("AppTextPrimary"))

                Text("\(item.year) • \(item.type.title)")
                    .font(.system(size: 13, weight: .medium))
                    .foregroundStyle(Color("AppSecondary"))

                HStack(spacing: 8) {
                    Image(systemName: "star.fill")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundStyle(.yellow)

                    Text(String(format: "%.1f", item.rating))
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundStyle(Color("AppTextPrimary"))
                }
            }

            Spacer()
        }
        .padding(12)
        .background(Color.white.opacity(0.06))
        .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
    }
}
