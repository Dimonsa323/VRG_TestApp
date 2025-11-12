//
//  LoadingView.swift
//  VRG_TestApp
//
//  Created by Дима Губеня on 8.11.2025.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack(spacing: 16) {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .appAccent))
                .scaleEffect(1.5)
            
            Text("Loading...")
                .font(.appBody)
                .foregroundColor(.appText)
        }
    }
}
