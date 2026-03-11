//
//  SearchResultRowView.swift
//  Nordic
//
//  Created by Lucas Silva on 25/02/26.
//

import SwiftUI

struct SearchResultRowView: View {
    let item: MediaItem
    
    var body: some View {
        HStack(spacing: 1) {
            RoundedRectangle(cornerRadius: 14, style:.continuous)
                .fill(Color.white.opacity(0.12))
                .frame(width: 68, height: 88)
                .padding(.trailing, 10)
            
            VStack(alignment: .leading, spacing: 8) {
                Text(item.title)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(Color("AppTextPrimary"))

                Text("\(item.year) ⦁ \(item.type.title)")
                    .font(.system(size: 13, weight: .medium))
                    .foregroundStyle(Color("AppSecondary"))
                
                HStack(spacing: 8) {
                    Image(systemName: "star.fill")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundStyle(.yellow)
                    
                    Text(String(format: "%.1f", item.rating))
                        .font(.system(size: 12, weight: .semibold))
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


