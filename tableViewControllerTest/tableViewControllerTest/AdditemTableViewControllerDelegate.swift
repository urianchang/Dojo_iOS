//
//  AdditemTableViewControllerDelegate.swift
//  tableViewControllerTest
//
//  Created by Urian Chang on 3/14/17.
//  Copyright © 2017 CodingDojo. All rights reserved.
//

import Foundation

protocol AddItemTableViewControllerDelegate: class {
    func itemSaved(by controller: addItemTableViewController, with text: String)
    func cancelButtonPressed(by controller: addItemTableViewController)
}
