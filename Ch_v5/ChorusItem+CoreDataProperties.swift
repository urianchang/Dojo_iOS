//
//  ChorusItem+CoreDataProperties.swift
//  Chorus
//
//  Created by Carolyn Yen on 3/30/17.
//  Copyright © 2017 frandz. All rights reserved.
//

import Foundation
import CoreData


extension ChorusItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ChorusItem> {
        return NSFetchRequest<ChorusItem>(entityName: "ChorusItem")
    }

    @NSManaged public var title: String?
    @NSManaged public var tempo: Int16
    @NSManaged public var song: NSObject?
    @NSManaged public var instrument: String?

}
