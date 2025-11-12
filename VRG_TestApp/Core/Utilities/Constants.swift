//
//  Constants.swift
//  VRG_TestApp
//
//  Created by Дима Губеня on 11.11.2025.
//

import Foundation

struct Constants {
    
    //MARK: - API Configuration
    
    struct API {
        static let baseURL = "https://newsapi.org/v2"
        static let apiKey = "85db05d8baf64296b1e2ace4ae993e17"
        static let pageSize = 20
    }
    
    //MARK: - Categories
    
    enum NewsCategory: String, CaseIterable {
        case business = "business"
        case entertainment = "entertainment"
        case health = "health"
        
        var displayName: String {
            switch self {
            case .business:
                return "Business"
            case .entertainment:
                return "Entertainment"
            case .health:
                return "Health"
            }
        }
    }
}
