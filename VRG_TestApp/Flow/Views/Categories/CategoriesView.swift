//
//  CategoriesView.swift
//  VRG_TestApp
//
//  Created by Дима Губеня on 10.11.2025.
//

import SwiftUI

struct CategoriesView: View {
    
    @StateObject private var viewModel = CategoriesViewModel()
    
    var body: some View {
        ZStack {
            Color.appBackground.ignoresSafeArea()
            
            VStack(spacing: 0) {
                headerView
                
                categoryButtonsView
                    .padding(.vertical, 12)
                
                if viewModel.isLoading && viewModel.articles.isEmpty {
                    Spacer()
                    LoadingView()
                    Spacer()
                } else if let errorMessage = viewModel.errorMessage, viewModel.articles.isEmpty {
                    Spacer()
                    EmptyStateView(
                        icon: "exclamationmark.triangle",
                        title: "Error",
                        message: errorMessage
                    )
                    Spacer()
                } else if viewModel.articles.isEmpty {
                    Spacer()
                    EmptyStateView(
                        icon: "newspaper",
                        title: "No News",
                        message: "No articles in this category"
                    )
                    Spacer()
                } else {
                    newsListView
                }
            }
        }
        .task {
            if viewModel.articles.isEmpty {
                await viewModel.fetchNews()
            }
        }
    }
    
    //MARK: - Header
    
    private var headerView: some View {
        Text("Categories")
            .font(.appTitle)
            .foregroundColor(.appText)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 16)
            .padding(.top, 16)
    }
    
    //MARK: - Category Buttons
    
    private var categoryButtonsView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(Constants.NewsCategory.allCases, id: \.self) { category in
                    CategoryButton(
                        category: category,
                        isSelected: viewModel.selectedCategory == category,
                        action: {
                            viewModel.selectCategory(category)
                        }
                    )
                }
            }
            .padding(.horizontal, 16)
        }
    }
    
    //MARK: - News List
    
    private var newsListView: some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                ForEach(viewModel.articles) { article in
                    NewsCard(
                        article: article,
                        isFavorite: viewModel.isFavorite(article),
                        onFavoriteToggle: {
                            viewModel.toggleFavorite(article)
                        }
                    )
                    .onAppear {
                        if article.id == viewModel.articles.last?.id {
                            Task {
                                await viewModel.fetchNews()
                            }
                        }
                    }
                }
                
                if viewModel.isLoading {
                    ProgressView()
                        .tint(.appAccent)
                        .padding()
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 16)
        }
        .refreshable {
            await viewModel.refresh()
        }
    }
}


