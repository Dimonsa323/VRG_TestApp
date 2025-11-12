//
//  CategoryButton.swift
//  VRG_TestApp
//
//  Created by Дима Губеня on 8.11.2025.
//

import SwiftUI

struct CategoryButton: View {
    let category: Constants.NewsCategory
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(category.displayName)
                .font(.appHeadline)
                .foregroundColor(isSelected ? .black : .appText)
                .padding(.horizontal, 20)
                .padding(.vertical, 12)
                .background(isSelected ? Color.appAccent : Color.appCardBackground)
                .cornerRadius(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(isSelected ? Color.appAccent : Color.appBorder, lineWidth: 1)
                )
        }
    }
}
