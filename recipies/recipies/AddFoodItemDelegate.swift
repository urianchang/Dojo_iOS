//
//  AddFoodItemDelegate.swift
//  recipies
//
//  Created by Glen Jantz on 3/23/17.
//  Copyright © 2017 Glen Jantz. All rights reserved.
//

import Foundation
import UIKit

protocol AddFoodItemDelegate: class {
    func cancelButtonPressed(by controller: AddFoodItemTableViewController)
    func saveButtonPressed(by controller: AddFoodItemTableViewController, with text: String, at indexPath: NSIndexPath?)
}
