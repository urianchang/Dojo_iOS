//
//  Recipe+CoreDataProperties.swift
//  recipies
//
//  Created by Glen Jantz on 3/23/17.
//  Copyright © 2017 Glen Jantz. All rights reserved.
//

import Foundation
import CoreData


extension Recipe {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Recipe> {
        return NSFetchRequest<Recipe>(entityName: "Recipe");
    }

    @NSManaged public var name: String?
    @NSManaged public var theactualrecipe: String?
    @NSManaged public var ingredients: NSOrderedSet?

}

// MARK: Generated accessors for ingredients
extension Recipe {

    @objc(insertObject:inIngredientsAtIndex:)
    @NSManaged public func insertIntoIngredients(_ value: FoodItem, at idx: Int)

    @objc(removeObjectFromIngredientsAtIndex:)
    @NSManaged public func removeFromIngredients(at idx: Int)

    @objc(insertIngredients:atIndexes:)
    @NSManaged public func insertIntoIngredients(_ values: [FoodItem], at indexes: NSIndexSet)

    @objc(removeIngredientsAtIndexes:)
    @NSManaged public func removeFromIngredients(at indexes: NSIndexSet)

    @objc(replaceObjectInIngredientsAtIndex:withObject:)
    @NSManaged public func replaceIngredients(at idx: Int, with value: FoodItem)

    @objc(replaceIngredientsAtIndexes:withIngredients:)
    @NSManaged public func replaceIngredients(at indexes: NSIndexSet, with values: [FoodItem])

    @objc(addIngredientsObject:)
    @NSManaged public func addToIngredients(_ value: FoodItem)

    @objc(removeIngredientsObject:)
    @NSManaged public func removeFromIngredients(_ value: FoodItem)

    @objc(addIngredients:)
    @NSManaged public func addToIngredients(_ values: NSOrderedSet)

    @objc(removeIngredients:)
    @NSManaged public func removeFromIngredients(_ values: NSOrderedSet)

}
