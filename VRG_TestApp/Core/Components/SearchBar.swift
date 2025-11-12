//
//  SearchBar.swift
//  VRG_TestApp
//
//  Created by Дима Губеня on 11.11.2025.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    let placeholder: String
    let onSearch: () -> Void
    
    var body: some View {
        HStack(spacing: 12) {
            HStack(spacing: 8) {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.appText.opacity(0.6))
                    .font(.system(size: 16))
                
                TextField(placeholder, text: $text)
                    .font(.appBody)
                    .foregroundColor(.appText)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .onSubmit {
                        onSearch()
                    }
                
                if !text.isEmpty {
                    Button(action: {
                        text = ""
                        onSearch()
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.appText.opacity(0.6))
                            .font(.system(size: 16))
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(Color.appCardBackground)
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.appBorder, lineWidth: 1)
            )
            
            if !text.isEmpty {
                Button(action: onSearch) {
                    Text("Search")
                        .font(.appHeadline)
                        .foregroundColor(.appAccent)
                }
            }
        }
    }
}
