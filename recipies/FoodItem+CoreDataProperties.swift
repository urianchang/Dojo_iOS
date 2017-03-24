//
//  FoodItem+CoreDataProperties.swift
//  recipies
//
//  Created by Glen Jantz on 3/23/17.
//  Copyright © 2017 Glen Jantz. All rights reserved.
//

import Foundation
import CoreData


extension FoodItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FoodItem> {
        return NSFetchRequest<FoodItem>(entityName: "FoodItem");
    }

    @NSManaged public var name: String?
    @NSManaged public var recipes: NSOrderedSet?

}

// MARK: Generated accessors for recipes
extension FoodItem {

    @objc(insertObject:inRecipesAtIndex:)
    @NSManaged public func insertIntoRecipes(_ value: Recipe, at idx: Int)

    @objc(removeObjectFromRecipesAtIndex:)
    @NSManaged public func removeFromRecipes(at idx: Int)

    @objc(insertRecipes:atIndexes:)
    @NSManaged public func insertIntoRecipes(_ values: [Recipe], at indexes: NSIndexSet)

    @objc(removeRecipesAtIndexes:)
    @NSManaged public func removeFromRecipes(at indexes: NSIndexSet)

    @objc(replaceObjectInRecipesAtIndex:withObject:)
    @NSManaged public func replaceRecipes(at idx: Int, with value: Recipe)

    @objc(replaceRecipesAtIndexes:withRecipes:)
    @NSManaged public func replaceRecipes(at indexes: NSIndexSet, with values: [Recipe])

    @objc(addRecipesObject:)
    @NSManaged public func addToRecipes(_ value: Recipe)

    @objc(removeRecipesObject:)
    @NSManaged public func removeFromRecipes(_ value: Recipe)

    @objc(addRecipes:)
    @NSManaged public func addToRecipes(_ values: NSOrderedSet)

    @objc(removeRecipes:)
    @NSManaged public func removeFromRecipes(_ values: NSOrderedSet)

}
