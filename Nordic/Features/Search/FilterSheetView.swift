//
//  FilterSheetView.swift
//  Nordic
//
//  Created by Lucas Silva on 23/02/26.
//

import SwiftUI

struct FilterSheetView: View {
    @Binding var filters: SearchFilters
    let genres: [Genre]
    
    var body: some View {
        ZStack {
            Color("AppBackground").ignoresSafeArea()
            
            ScrollView {
                VStack(alignment: .leading, spacing: 18) {
                    Text("Filters")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundStyle(Color("ÄppTextPrimary"))
                    
                    // Tipo (All / Movies / TV)
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Type")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundStyle(Color("AppTextPrimary"))
                        HStack(spacing: 10) {
                            ForEach(MediaType.allCases) {type in
                                GenreChipView(
                                    title: type.title, isSelected: filters.mediaType == type
                                ) {
                                    filters.mediaType = type
                                }
                            }
                        }
                    }
                    
                    //Genêro (multi-select)
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Genres")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundStyle(Color("AppTextPrimary"))
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing:10) {
                                ForEach(genres) {genre in
                                    GenreChipView(
                                        title: genre.name,
                                        isSelected: filters.selectedGenreIds.contains(genre.id)
                                    ) {
                                        toggleGenre(genre.id)
                                    }
                                }
                            }
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Text("Minimum rating")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundStyle(Color("AppTextPrimary"))
                            
                            Spacer()
                            
                            Text(String(format: "%.1f", filters.minimunRating))
                                .font(.system(size: 14, weight: .medium))
                                .foregroundStyle(Color("AppSecondary"))
                        }
                        
                        Slider(value: $filters.minimunRating, in: 0...10, step: 0.5)
                    }
                    
                    Button {
                        filters = SearchFilters()
                    } label: {
                        Text("Reset filters")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundStyle(Color("AppTextPrimary"))
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 14)
                            .background(Color.white.opacity(0.10))
                            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                    }
                    .buttonStyle(.plain)
                    
                    Spacer().frame(height: 20)
                }
                .padding(.horizontal, 10)
                .padding(.top, 16)
            }
        }
        
        .presentationDetents([.medium, .large])
        .presentationDragIndicator(.hidden)
    }
    
    private func toggleGenre(_ id: Int) {
       if filters.selectedGenreIds.contains(id) {
           filters.selectedGenreIds.remove(id)
       } else {
           filters.selectedGenreIds.insert(id)
       }
   }
}

