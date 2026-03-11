//
//  PosterCardView.swift
//  Nordic
//
//  Created by Lucas Renan on 10/02/26.
//

import SwiftUI

struct PosterCardView: View {
    let item: MediaItem
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .frame(width: 140, height: 200)
                .overlay(
                    Text("Poster")
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundStyle(Color("AppTextPrimary"))
                )
            Text(item.title)
                .font(.system(size: 14, weight: .semibold))
                .foregroundStyle(Color("AppTextPrimary"))
                .lineLimit(1)

            HStack(spacing: 8) {
                Text(item.year)
                    .font(.system(size: 12))
                    .foregroundStyle(Color("AppSecondary"))

                Text("•")
                    .foregroundStyle(Color("AppSecondary"))

                Image(systemName: "star.fill")
                    .font(.system(size: 12))
                    .foregroundStyle(.yellow)

                Text(String(format: "%.1f", item.rating))
                    .font(.system(size: 12, weight: .medium))
                    .foregroundStyle(Color("AppTextPrimary"))
            }
        }
    }
}
