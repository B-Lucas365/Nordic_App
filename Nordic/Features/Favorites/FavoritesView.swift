//
//  FavoritesView.swift
//  Nordic
//
//  Created by Lucas Renan on 10/02/26.
//

import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject private var favoritesStore: FavoritesStore
    
    var body: some View {
        
        NavigationStack {
            ZStack {
                Color("AppBackground").ignoresSafeArea()
                
                if favoritesStore.favoriteItems.isEmpty {
                    emptyState
                } else {
                    listState
                }
            }
            .navigationTitle("Favorites")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color("AppBackground"), for:.navigationBar)
            .toolbarBackgroundVisibility(.visible, for: .navigationBar)
            .toolbarColorScheme(.dark, for:.navigationBar)
            .navigationDestination(for: MediaItem.self) {item in
                DetailView(item: item)
            }
        }
    }
    
    private var listState: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 14) {
                ForEach(favoritesStore.favoriteItems) {item in
                    NavigationLink(value: item) {
                        SearchResultRowView(item: item)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal, 18)
            .padding(.top, 12)
            .padding(.bottom, 30)
        }
    }
    
    private var emptyState: some View {
        VStack(spacing: 14) {
            Image(systemName: "bookmark")
                .font(.system(size: 44, weight: .semibold))
                .foregroundStyle(Color("AppSecondary"))
            
            Text("Your favorites list is empty")
                .font(.system(size: 18, weight: .semibold))
                .foregroundStyle(Color("AppTextPrimary"))
            
            Text("Add movies or shows to your favorites to see them listed here.")
                .font(.system(size: 14))
                .foregroundStyle(Color("AppSecondary"))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 28)
            
            Button {
                print("Brouse tapped")
            } label: {
                Text("Browse popular titles")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(Color("AppTextPrimary"))
                    .padding(.horizontal, 18)
                    .padding(.vertical, 12)
                    .background(Color.white.opacity(0.10))
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            }
            .buttonStyle(.plain)
        }
        .padding(.top, 40)
    }
}


