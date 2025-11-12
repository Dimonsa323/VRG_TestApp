//
//  FavoritesView.swift
//  VRG_TestApp
//
//  Created by Дима Губеня on 10.11.2025.
//

import SwiftUI

struct FavoritesView: View {
    
    @StateObject private var viewModel = FavoritesViewModel()
    
    var body: some View {
        ZStack {
            Color.appBackground.ignoresSafeArea()
            
            VStack(spacing: 0) {
                headerView
                
                if viewModel.isLoading {
                    Spacer()
                    LoadingView()
                    Spacer()
                } else if viewModel.articles.isEmpty {
                    Spacer()
                    EmptyStateView(
                        icon: "heart.slash",
                        title: "No Favorites",
                        message: "Start adding articles to your favorites"
                    )
                    Spacer()
                } else {
                    newsListView
                }
            }
        }
        .onAppear {
            viewModel.fetchFavorites()
        }
    }
    
    //MARK: - Header
    
    private var headerView: some View {
        Text("Favorites")
            .font(.appTitle)
            .foregroundColor(.appText)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 16)
            .padding(.top, 16)
            .padding(.bottom, 12)
    }
    
    //MARK: - News List
    
    private var newsListView: some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                ForEach(viewModel.articles) { article in
                    NewsCard(
                        article: article,
                        isFavorite: true,
                        onFavoriteToggle: {
                            viewModel.removeFavorite(article)
                        }
                    )
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

