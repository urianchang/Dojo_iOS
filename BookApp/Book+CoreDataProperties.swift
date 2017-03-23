//
//  Book+CoreDataProperties.swift
//  BookApp
//
//  Created by Urian Chang on 3/22/17.
//  Copyright © 2017 CodingDojo. All rights reserved.
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension Book {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Book> {
        return NSFetchRequest<Book>(entityName: "Book");
    }

    @NSManaged public var title: String?
    @NSManaged public var author: Author?

}
