//
//  Untitled.swift
//  Nordic
//
//  Created by Lucas Renan on 10/02/26.
//

import SwiftUI

struct SectionHeaderView: View {
    let title: String
    var onSeeAll: () -> Void = {}
    
    var body: some View {
        HStack {
            Text(title)
                .font(.system(size: 22, weight: .semibold))
                .foregroundStyle(Color("AppTextPrimary"))
            
            Spacer()
            
            Button("See all", action: onSeeAll)
                .font(.system(size: 14, weight: .medium))
                .foregroundStyle(Color("AppSecondary"))
        }
    }
}
