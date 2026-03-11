//
//  SearchBarView.swift
//  Nordic
//
//  Created by Lucas Renan on 10/02/26.
//
import SwiftUI

struct SearchBarView: View {
    @Binding var text: String
    var onFilterTap: () -> Void = {}
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(Color("AppSecondary"))
            
            TextField("Movie, series, shows...", text: $text)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled(true)
                .foregroundStyle(Color("AppTextPrimary"))
            
            Button(action: onFilterTap) {
                Image(systemName: "slider.horizontal.3")
                    .foregroundStyle(Color("AppTextPrimary"))
                    .padding(10)
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
            }
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 12)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
    }
}
