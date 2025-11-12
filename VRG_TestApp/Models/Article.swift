//
//  Article.swift
//  VRG_TestApp
//
//  Created by Дима Губеня on 11.11.2025.
//

import Foundation

//MARK: - Article Model

struct Article: Identifiable, Codable, Hashable {
    let id = UUID()
    let source: Source
    let author: String?
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
    let publishedAt: String
    let content: String?
    
    enum CodingKeys: String, CodingKey {
        case source
        case author
        case title
        case description
        case url
        case urlToImage
        case publishedAt
        case content
    }
    
    //MARK: - Computed Properties
    
    var formattedDate: String {
        let formatter = ISO8601DateFormatter()
        if let date = formatter.date(from: publishedAt) {
            let displayFormatter = DateFormatter()
            displayFormatter.dateStyle = .medium
            displayFormatter.timeStyle = .short
            return displayFormatter.string(from: date)
        }
        return publishedAt
    }
    
    var imageURL: URL? {
        guard let urlString = urlToImage else { return nil }
        return URL(string: urlString)
    }
}

//MARK: - Source Model

struct Source: Codable, Hashable {
    let id: String?
    let name: String
}
