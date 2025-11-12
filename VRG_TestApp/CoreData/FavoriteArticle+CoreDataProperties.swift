//
//  FavoriteArticle+CoreDataProperties.swift
//  VRG_TestApp
//
//  Created by Дима Губеня on 12.11.2025.
//
//

import Foundation
import CoreData


extension FavoriteArticle {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteArticle> {
        return NSFetchRequest<FavoriteArticle>(entityName: "FavoriteArticle")
    }

    @NSManaged public var id: String?
    @NSManaged public var title: String?
    @NSManaged public var articleDescription: String?
    @NSManaged public var url: String?
    @NSManaged public var urlToImage: String?
    @NSManaged public var publishedAt: String?
    @NSManaged public var sourceName: String?
    @NSManaged public var author: String?
    @NSManaged public var content: String?

}

extension FavoriteArticle : Identifiable {

}
