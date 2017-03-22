//
//  Dog+CoreDataProperties.swift
//  myDogs
//
//  Created by Urian Chang on 3/21/17.
//  Copyright © 2017 CodingDojo. All rights reserved.
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension Dog {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Dog> {
        return NSFetchRequest<Dog>(entityName: "Dog");
    }

    @NSManaged public var name: String?
    @NSManaged public var color: String?
    @NSManaged public var treat: String?
    @NSManaged public var photo: NSData?

}
