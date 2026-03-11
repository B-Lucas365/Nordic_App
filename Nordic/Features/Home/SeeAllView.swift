//
//  SeeAllView.swift
//  Nordic
//
//  Created by Lucas Silva on 25/02/26.
//

import SwiftUI

struct SeeAllView: View {
    let title: String
    let items: [MediaItem]
    
    private let columns = [
        GridItem(.adaptive(minimum: 150), spacing: 14)
    ]
    
    var body: some View {
        ZStack {
            Color.appBackground.ignoresSafeArea()
            
            ScrollView {
                VStack(alignment: .leading, spacing: 14) {
                    ForEach(items) {item in
                        NavigationLink {
                            DetailView(item: item)
                        } label: {
                            SearchResultRowView(item: item)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.horizontal, 18)
                .padding(.top, 10)
                .padding(.bottom, 30)
            }
            .scrollIndicators(.hidden)
        }
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(Color("AppBackground"), for: .navigationBar)
        .toolbarBackgroundVisibility(.visible, for: .navigationBar)
        .toolbarColorScheme(.dark, for: .navigationBar)
        
    }
}
