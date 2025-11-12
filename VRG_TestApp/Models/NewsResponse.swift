//
//  NewsResponse.swift
//  VRG_TestApp
//
//  Created by Дима Губеня on 11.11.2025.
//

import Foundation

//MARK: - News Response

struct NewsResponse: Codable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}

//MARK: - API Error

enum APIError: Error, LocalizedError {
    case invalidURL
    case invalidResponse
    case decodingError
    case serverError(String)
    case networkError(Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .invalidResponse:
            return "Invalid response from server"
        case .decodingError:
            return "Failed to decode response"
        case .serverError(let message):
            return message
        case .networkError(let error):
            return error.localizedDescription
        }
    }
}
