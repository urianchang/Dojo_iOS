//
//  ItemObject+CoreDataProperties.swift
//  CoreDataRef
//
//  Created by Urian Chang on 3/20/17.
//  Copyright © 2017 CodingDojo. All rights reserved.
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension ItemObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ItemObject> {
        return NSFetchRequest<ItemObject>(entityName: "ItemObject");
    }

    @NSManaged public var name: String?

}
