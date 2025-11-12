//
//  FavoritesViewModel.swift
//  VRG_TestApp
//
//  Created by Дима Губеня on 10.11.2025.
//

import Foundation
import Combine

@MainActor
class FavoritesViewModel: ObservableObject {
    
    @Published var articles: [Article] = []
    @Published var isLoading = false
    
    private let coreDataManager = CoreDataManager.shared
    
    //MARK: - Fetch Favorites
    
    func fetchFavorites() {
        isLoading = true
        articles = coreDataManager.fetchAllFavorites()
        isLoading = false
    }
    
    //MARK: - Refresh
    
    func refresh() async {
        fetchFavorites()
    }
    
    //MARK: - Remove Favorite
    
    func removeFavorite(_ article: Article) {
        coreDataManager.removeFavorite(article: article)
        fetchFavorites()
    }
    
    //MARK: - Check if Favorite
    
    func isFavorite(_ article: Article) -> Bool {
        return coreDataManager.isFavorite(article: article)
    }
}
