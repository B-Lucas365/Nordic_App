//
//  FavoritesView.swift
//  Nordic
//
//  Created by Lucas Renan on 10/02/26.
//

import SwiftUI

enum FavoritesSegment: String, CaseIterable, Identifiable {
    case favorites, washlist
    var id: String {rawValue}
    
    var title: String {
        switch self {
        case .favorites:
            return "Favorites"
        case .washlist:
            return "WatchList"
        }
    }
}

struct FavoritesView: View {
    @EnvironmentObject private var favoritesStore: FavoritesStore
    @State private var segment:FavoritesSegment = .favorites
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("AppBackground").ignoresSafeArea()
                
                VStack (spacing: 14) {
                    segmentControl
                    
                    if currentItems.isEmpty {
                        emptyState
                    } else {
                        listState
                    }
                }
                .padding(.horizontal, 18)
                .padding(.top, 12)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
               
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
    
    private var segmentControl: some View {
        Picker("List", selection: $segment) {
            ForEach(FavoritesSegment.allCases) {s in
                Text(s.title).tag(s)
            }
        }
        .pickerStyle(.segmented)
    }
    
    private var currentItems: [MediaItem] {
        switch segment {
        case .favorites:
            return favoritesStore.favoriteItems
        case .washlist:
            return favoritesStore.watchListItems
        }
    }
    
    private var listState: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 14) {
                ForEach(currentItems) {item in
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
            Image(systemName: segment == .favorites ? "heart" : "bookmark")
                .font(.system(size: 44, weight: .semibold))
                .foregroundStyle(Color("AppSecondary"))

            Text(segment == .favorites ? "No favorites yet" : "Your watchlist is empty")
                .font(.system(size: 18, weight: .semibold))
                .foregroundStyle(Color("AppTextPrimary"))

            Text(segment == .favorites
                 ? "Tap the heart on a title to keep it here."
                 : "Tap the bookmark on a title to save it for later.")
                .font(.system(size: 14))
                .foregroundStyle(Color("AppSecondary"))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 28)

            Button {
                print("browse tapped")
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
        .padding(.top, 26)
        .frame(maxWidth: .infinity)
    }
}


