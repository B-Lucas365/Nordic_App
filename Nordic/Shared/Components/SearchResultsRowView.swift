//
//  SearchResultsRowView.swift
//  Nordic
//
//  Created by Lucas Silva on 25/02/26.
//

import SwiftUI

struct SearchResultsRowView: View {
    let item: MediaItem
    
    var body: some View {
        HStack(spacing: 14) {
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .fill(Color.white.opacity(0.12))
                .frame(width: 68, height: 88)
        }
    }
}
