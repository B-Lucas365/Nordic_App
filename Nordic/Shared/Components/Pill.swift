//
//  Pill.swift
//  Nordic
//
//  Created by Lucas Renan on 11/02/26.
//

import SwiftUI

struct Pill: View {
    let text: String
    
    var body: some View {
        Text(text)
            .font(.system(size: 13, weight: .semibold))
            .foregroundStyle(Color("AppTextPrimary"))
            .padding(.horizontal, 14)
            .padding(.vertical, 10)
            .background(Color.white.opacity(0.10))
            .clipShape(Capsule())
    }
}
