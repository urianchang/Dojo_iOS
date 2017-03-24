//
//  ItemViewControllerDelegate.swift
//  tabBarPractice
//
//  Created by Urian Chang on 3/23/17.
//  Copyright © 2017 CodingDojo. All rights reserved.
//

import Foundation
protocol ItemViewControllerDelegate: class {
    func itemSaved(by controller: ItemViewController)
    func itemCancel(by controller: ItemViewController)
}
