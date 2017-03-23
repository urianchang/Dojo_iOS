//
//  Author+CoreDataProperties.swift
//  BookApp
//
//  Created by Urian Chang on 3/22/17.
//  Copyright © 2017 CodingDojo. All rights reserved.
//

import Foundation
import CoreData


extension Author {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Author> {
        return NSFetchRequest<Author>(entityName: "Author");
    }

    @NSManaged public var name: String?
    @NSManaged public var books: NSOrderedSet?

}

// MARK: Generated accessors for books
extension Author {

    @objc(insertObject:inBooksAtIndex:)
    @NSManaged public func insertIntoBooks(_ value: Book, at idx: Int)

    @objc(removeObjectFromBooksAtIndex:)
    @NSManaged public func removeFromBooks(at idx: Int)

    @objc(insertBooks:atIndexes:)
    @NSManaged public func insertIntoBooks(_ values: [Book], at indexes: NSIndexSet)

    @objc(removeBooksAtIndexes:)
    @NSManaged public func removeFromBooks(at indexes: NSIndexSet)

    @objc(replaceObjectInBooksAtIndex:withObject:)
    @NSManaged public func replaceBooks(at idx: Int, with value: Book)

    @objc(replaceBooksAtIndexes:withBooks:)
    @NSManaged public func replaceBooks(at indexes: NSIndexSet, with values: [Book])

    @objc(addBooksObject:)
    @NSManaged public func addToBooks(_ value: Book)

    @objc(removeBooksObject:)
    @NSManaged public func removeFromBooks(_ value: Book)

    @objc(addBooks:)
    @NSManaged public func addToBooks(_ values: NSOrderedSet)

    @objc(removeBooks:)
    @NSManaged public func removeFromBooks(_ values: NSOrderedSet)

}
