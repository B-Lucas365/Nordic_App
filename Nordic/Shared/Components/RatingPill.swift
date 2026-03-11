//
//  RatingPill.swift
//  Nordic
//
//  Created by Lucas Renan on 11/02/26.
//

import SwiftUI

struct RatingPill: View {
    let rating: Double
    var body: some View {
        
        HStack(spacing: 8) {
            Image(systemName: "star.fill")
                .font(.system(size: 13, weight: .semibold))
                .foregroundStyle(.yellow)
            Text(String(format: "%.1f", rating))
                .font(.system(size: 13, weight: .semibold))
                .foregroundStyle(Color("AppTextPrimary"))
            
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 10)
        .background(Color.white.opacity(0.10))
        .clipShape(Capsule())
    }
}
