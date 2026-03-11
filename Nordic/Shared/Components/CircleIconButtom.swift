//
//  CircleIconButtom.swift
//  Nordic
//
//  Created by Lucas Renan on 11/02/26.
//

import SwiftUI

struct CircleIconButtom: View {
    @Environment(\.dismiss) private var dismiss

    let systemImage: String
    var action: (() -> Void)? = nil
    
    var body: some View {
        Button {
            if let action { action() }
            else {dismiss()}
        } label: {
            Image(systemName: systemImage)
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(Color("AppTextPrimary"))
                .frame(width: 44, height: 44)
                .background(.ultraThinMaterial)
                .clipShape(Circle())
        }
        .buttonStyle(.plain)
    }
}
