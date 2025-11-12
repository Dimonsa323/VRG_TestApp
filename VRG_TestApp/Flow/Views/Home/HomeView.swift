//
//  HomeView.swift
//  VRG_TestApp
//
//  Created by Дима Губеня on 10.11.2025.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject private var viewModel = HomeViewModel()
    
    var body: some View {
        ZStack {
            Color.appBackground.ignoresSafeArea()
            
            VStack(spacing: 0) {
                headerView
                
                SearchBar(
                    text: $viewModel.searchQuery,
                    placeholder: "Search news...",
                    onSearch: {
                        Task {
                            await viewModel.resetAndFetchNews()
                        }
                    }
                )
                .padding(.horizontal, 16)
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
                        message: "Try searching for something else"
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
        Text("News")
            .font(.appTitle)
            .foregroundColor(.appText)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 16)
            .padding(.top, 16)
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

