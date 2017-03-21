//
//  ItemObject+CoreDataProperties.swift
//  toDoList
//
//  Created by Urian Chang on 3/21/17.
//  Copyright © 2017 CodingDojo. All rights reserved.
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension ItemObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ItemObject> {
        return NSFetchRequest<ItemObject>(entityName: "ItemObject");
    }

    @NSManaged public var title: String?
    @NSManaged public var detail: String?
    @NSManaged public var date: String?
    @NSManaged public var completed: Bool

}
