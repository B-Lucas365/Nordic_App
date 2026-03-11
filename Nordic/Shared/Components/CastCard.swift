//
//  CastCard.swift
//  Nordic
//
//  Created by Lucas Renan on 11/02/26.
//

import SwiftUI

struct CastCard: View {
    let name: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(Color.white.opacity(0.12))
                .frame(width: 110, height: 130)
            
            Text(name)
                .font(.system(size: 13, weight: .semibold))
                .foregroundStyle(Color("AppTextPrimary"))
        }
        .frame(width: 110)
        
    }
}
