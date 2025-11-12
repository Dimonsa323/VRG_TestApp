//
//  CoreDataManager.swift
//  VRG_TestApp
//
//  Created by Дима Губеня on 11.11.2025.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    private init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "VRG_TestApp")
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Unable to load persistent stores: \(error)")
            }
        }
        return container
    }()
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    //MARK: - Save Context
    
    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Error saving context: \(error)")
            }
        }
    }
    
    //MARK: - Add Favorite
    
    func addFavorite(article: Article) {
        let favorite = FavoriteArticle(context: context)
        favorite.id = article.url
        favorite.title = article.title
        favorite.articleDescription = article.description
        favorite.url = article.url
        favorite.urlToImage = article.urlToImage
        favorite.publishedAt = article.publishedAt
        favorite.sourceName = article.source.name
        favorite.author = article.author
        favorite.content = article.content
        
        saveContext()
    }
    
    //MARK: - Remove Favorite
    
    func removeFavorite(article: Article) {
        let fetchRequest: NSFetchRequest<FavoriteArticle> = FavoriteArticle.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", article.url)
        
        do {
            let results = try context.fetch(fetchRequest)
            for favorite in results {
                context.delete(favorite)
            }
            saveContext()
        } catch {
            print("Error removing favorite: \(error)")
        }
    }
    
    //MARK: - Check if Favorite
    
    func isFavorite(article: Article) -> Bool {
        let fetchRequest: NSFetchRequest<FavoriteArticle> = FavoriteArticle.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", article.url)
        
        do {
            let count = try context.count(for: fetchRequest)
            return count > 0
        } catch {
            print("Error checking favorite: \(error)")
            return false
        }
    }
    
    //MARK: - Fetch All Favorites
    
    func fetchAllFavorites() -> [Article] {
        let fetchRequest: NSFetchRequest<FavoriteArticle> = FavoriteArticle.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "publishedAt", ascending: false)]
        
        do {
            let favorites = try context.fetch(fetchRequest)
            return favorites.map { favorite in
                Article(
                    source: Source(id: nil, name: favorite.sourceName ?? "Unknown"),
                    author: favorite.author,
                    title: favorite.title ?? "",
                    description: favorite.articleDescription,
                    url: favorite.url ?? "",
                    urlToImage: favorite.urlToImage,
                    publishedAt: favorite.publishedAt ?? "",
                    content: favorite.content
                )
            }
        } catch {
            print("Error fetching favorites: \(error)")
            return []
        }
    }
    
    //MARK: - Toggle Favorite
    
    func toggleFavorite(article: Article) {
        if isFavorite(article: article) {
            removeFavorite(article: article)
        } else {
            addFavorite(article: article)
        }
    }
}
