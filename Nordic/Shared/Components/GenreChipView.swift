//
//  GenreChipView.swift
//  Nordic
//
//  Created by Lucas Renan on 10/02/26.
//

import SwiftUI

struct GenreChipView: View {
    let title: String
    let isSelected: Bool
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            Text(title)
                .font(.system(size: 14, weight: .semibold))
                .foregroundStyle(isSelected ? Color("AppBackground") : Color("AppTextPrimary"))
                .padding(.horizontal, 16)
                .padding(.vertical, 10)
                .background(isSelected ? Color("AppTextPrimary") : Color.white.opacity(0.10))
                .clipShape(Capsule())
        }
        .buttonStyle(.plain)
    }
}
