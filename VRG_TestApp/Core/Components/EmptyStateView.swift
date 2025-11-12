//
//  EmptyStateView.swift
//  VRG_TestApp
//
//  Created by Дима Губеня on 9.11.2025.
//

import SwiftUI

struct EmptyStateView: View {
    let icon: String
    let title: String
    let message: String
    
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: icon)
                .font(.system(size: 60))
                .foregroundColor(.appText.opacity(0.3))
            
            Text(title)
                .font(.appTitle3)
                .foregroundColor(.appText)
            
            Text(message)
                .font(.appBody)
                .foregroundColor(.appText.opacity(0.6))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)
        }
    }
}
