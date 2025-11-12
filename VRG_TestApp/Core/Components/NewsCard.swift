//
//  NewsCard.swift
//  VRG_TestApp
//
//  Created by Дима Губеня on 8.11.2025.
//

//import SwiftUI
//
//struct NewsCard: View {
//    let article: Article
//    let isFavorite: Bool
//    let onFavoriteToggle: () -> Void
//    
//    var body: some View {
//        VStack(alignment: .leading, spacing: 0) {
//            if let imageURL = article.imageURL {
//                AsyncImage(url: imageURL) { phase in
//                    switch phase {
//                    case .empty:
//                        Rectangle()
//                            .fill(Color.appCardBackground)
//                            .frame(height: 200)
//                            .frame(maxWidth: .infinity)
//                            .overlay(
//                                ProgressView()
//                                    .tint(.appAccent)
//                            )
//                    case .success(let image):
//                        image
//                            .resizable()
//                            .scaledToFill()
//                            .frame(height: 200)
//                            .frame(maxWidth: .infinity)
//                            .clipped()
//                    case .failure:
//                        Rectangle()
//                            .fill(Color.appCardBackground)
//                            .frame(height: 200)
//                            .frame(maxWidth: .infinity)
//                            .overlay(
//                                Image(systemName: "photo")
//                                    .foregroundColor(.appText)
//                                    .font(.largeTitle)
//                            )
//                    @unknown default:
//                        EmptyView()
//                    }
//                }
//            }
//            
//            VStack(alignment: .leading, spacing: 8) {
//                HStack(spacing: 8) {
//                    Text(article.source.name)
//                        .font(.appCaption)
//                        .foregroundColor(.appAccent)
//                        .lineLimit(1)
//                    
//                    Spacer(minLength: 0)
//                    
//                    Button(action: onFavoriteToggle) {
//                        Image(systemName: isFavorite ? "heart.fill" : "heart")
//                            .foregroundColor(isFavorite ? .appAccent : .appText)
//                            .font(.system(size: 18))
//                    }
//                }
//                
//                Text(article.title)
//                    .font(.appHeadline)
//                    .foregroundColor(.appText)
//                    .lineLimit(2)
//                    .fixedSize(horizontal: false, vertical: true)
//                
//                if let description = article.description {
//                    Text(description)
//                        .font(.appSubheadline)
//                        .foregroundColor(.appText.opacity(0.6))
//                        .lineLimit(2)
//                        .fixedSize(horizontal: false, vertical: true)
//                }
//                
//                Text(article.formattedDate)
//                    .font(.appCaption)
//                    .foregroundColor(.appText.opacity(0.5))
//                    .lineLimit(1)
//            }
//            .padding(12)
//            .frame(maxWidth: .infinity, alignment: .leading)
//        }
//        .frame(maxWidth: .infinity)
//        .background(Color.appCardBackground)
//        .clipShape(RoundedRectangle(cornerRadius: 12))
//        .overlay(
//            RoundedRectangle(cornerRadius: 12)
//                .stroke(Color.appBorder, lineWidth: 1)
//        )
//    }
//}

import SwiftUI

struct NewsCard: View {
    let article: Article
    let isFavorite: Bool
    let onFavoriteToggle: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            if let imageURL = article.imageURL {
                GeometryReader { geometry in
                    AsyncImage(url: imageURL) { phase in
                        switch phase {
                        case .empty:
                            Rectangle()
                                .fill(Color.appCardBackground)
                                .frame(width: geometry.size.width, height: 200)
                                .overlay(
                                    ProgressView()
                                        .tint(.appAccent)
                                )
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: geometry.size.width, height: 200)
                                .clipped()
                        case .failure:
                            Rectangle()
                                .fill(Color.appCardBackground)
                                .frame(width: geometry.size.width, height: 200)
                                .overlay(
                                    Image(systemName: "photo")
                                        .foregroundColor(.appText)
                                        .font(.largeTitle)
                                )
                        @unknown default:
                            EmptyView()
                        }
                    }
                }
                .frame(height: 200)
            }
            
            VStack(alignment: .leading, spacing: 8) {
                HStack(spacing: 8) {
                    Text(article.source.name)
                        .font(.appCaption)
                        .foregroundColor(.appAccent)
                        .lineLimit(1)
                    
                    Spacer(minLength: 0)
                    
                    Button(action: onFavoriteToggle) {
                        Image(systemName: isFavorite ? "heart.fill" : "heart")
                            .foregroundColor(isFavorite ? .appAccent : .appText)
                            .font(.system(size: 18))
                    }
                }
                
                Text(article.title)
                    .font(.appHeadline)
                    .foregroundColor(.appText)
                    .lineLimit(2)
                
                if let description = article.description {
                    Text(description)
                        .font(.appSubheadline)
                        .foregroundColor(.appText.opacity(0.6))
                        .lineLimit(2)
                }
                
                Text(article.formattedDate)
                    .font(.appCaption)
                    .foregroundColor(.appText.opacity(0.5))
                    .lineLimit(1)
            }
            .padding(12)
        }
        .background(Color.appCardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.appBorder, lineWidth: 1)
        )
    }
}
