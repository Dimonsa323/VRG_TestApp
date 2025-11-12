//
//  HomeViewModel.swift
//  VRG_TestApp
//
//  Created by Дима Губеня on 10.11.2025.
//

import Foundation
import Combine

@MainActor
class HomeViewModel: ObservableObject {
    
    @Published var articles: [Article] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var searchQuery: String = "tesla"
    @Published var currentPage = 1
    @Published var canLoadMore = true
    
    private let networkService = NetworkService.shared
    private let coreDataManager = CoreDataManager.shared
    private var cancellables = Set<AnyCancellable>()
    
    //MARK: - Init
    
    init() {
        setupSearch()
    }
    
    //MARK: - Setup Search
    
    private func setupSearch() {
        $searchQuery
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] _ in
                Task {
                    await self?.resetAndFetchNews()
                }
            }
            .store(in: &cancellables)
    }
    
    //MARK: - Fetch News
    
    func fetchNews() async {
        guard !isLoading && canLoadMore else { return }
        
        isLoading = true
        errorMessage = nil
        
        do {
            let newArticles = try await networkService.fetchNews(
                query: searchQuery.isEmpty ? "tesla" : searchQuery,
                page: currentPage
            )
            
            articles.append(contentsOf: newArticles)
            currentPage += 1
            canLoadMore = !newArticles.isEmpty
        } catch {
            errorMessage = error.localizedDescription
            canLoadMore = false
        }
        
        isLoading = false
    }
    
    //MARK: - Reset and Fetch
    
    func resetAndFetchNews() async {
        articles = []
        currentPage = 1
        canLoadMore = true
        await fetchNews()
    }
    
    //MARK: - Refresh
    
    func refresh() async {
        await resetAndFetchNews()
    }
    
    //MARK: - Favorites
    
    func isFavorite(_ article: Article) -> Bool {
        return coreDataManager.isFavorite(article: article)
    }
    
    func toggleFavorite(_ article: Article) {
        coreDataManager.toggleFavorite(article: article)
        objectWillChange.send()
    }
}
