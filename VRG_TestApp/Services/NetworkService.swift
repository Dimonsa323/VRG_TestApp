//
//  NetworkService.swift
//  VRG_TestApp
//
//  Created by Дима Губеня on 11.11.2025.
//

import Foundation
import Combine

class NetworkService {
    
    static let shared = NetworkService()
    
    private init() {}
    
    //MARK: - Fetch News
    
    func fetchNews(query: String = "tesla", category: String? = nil, page: Int = 1) async throws -> [Article] {
        var components = URLComponents(string: "\(Constants.API.baseURL)/everything")
        
        var queryItems: [URLQueryItem] = [
            URLQueryItem(name: "q", value: query),
            URLQueryItem(name: "sortBy", value: "publishedAt"),
            URLQueryItem(name: "apiKey", value: Constants.API.apiKey),
            URLQueryItem(name: "page", value: "\(page)"),
            URLQueryItem(name: "pageSize", value: "\(Constants.API.pageSize)")
        ]
        
        if let category = category {
            queryItems.append(URLQueryItem(name: "category", value: category))
        }
        
        components?.queryItems = queryItems
        
        guard let url = components?.url else {
            throw APIError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.timeoutInterval = 15
        request.cachePolicy = .reloadIgnoringLocalCacheData
        
        print("Fetching news from: \(url.absoluteString)")
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw APIError.invalidResponse
            }
            
            print("Server response status code: \(httpResponse.statusCode)")
            
            guard (200...299).contains(httpResponse.statusCode) else {
                let errorMessage = String(data: data, encoding: .utf8) ?? "Unknown error"
                print("Error response: \(errorMessage)")
                throw APIError.serverError(errorMessage)
            }
            
            if let jsonString = String(data: data, encoding: .utf8) {
                print("Received JSON data preview: \(jsonString.prefix(200))...")
            }
            
            do {
                let decoder = JSONDecoder()
                let newsResponse = try decoder.decode(NewsResponse.self, from: data)
                print("Successfully decoded \(newsResponse.articles.count) articles")
                return newsResponse.articles
            } catch {
                print("JSON decoding error: \(error)")
                throw APIError.decodingError
            }
        } catch let error as APIError {
            throw error
        } catch {
            print("Network request error: \(error)")
            throw APIError.networkError(error)
        }
    }
    
    //MARK: - Fetch News by Category
    
    func fetchNewsByCategory(_ category: Constants.NewsCategory, page: Int = 1) async throws -> [Article] {
        var components = URLComponents(string: "\(Constants.API.baseURL)/top-headlines")
        
        components?.queryItems = [
            URLQueryItem(name: "category", value: category.rawValue),
            URLQueryItem(name: "apiKey", value: Constants.API.apiKey),
            URLQueryItem(name: "page", value: "\(page)"),
            URLQueryItem(name: "pageSize", value: "\(Constants.API.pageSize)")
        ]
        
        guard let url = components?.url else {
            throw APIError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.timeoutInterval = 15
        request.cachePolicy = .reloadIgnoringLocalCacheData
        
        print("Fetching news by category from: \(url.absoluteString)")
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw APIError.invalidResponse
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                let errorMessage = String(data: data, encoding: .utf8) ?? "Unknown error"
                throw APIError.serverError(errorMessage)
            }
            
            let decoder = JSONDecoder()
            let newsResponse = try decoder.decode(NewsResponse.self, from: data)
            return newsResponse.articles
        } catch let error as APIError {
            throw error
        } catch {
            throw APIError.networkError(error)
        }
    }
    
    //MARK: - Check API Availability
    
    func checkAPIAvailability() async -> Bool {
        do {
            let _ = try await fetchNews(query: "test", page: 1)
            return true
        } catch {
            return false
        }
    }
}
