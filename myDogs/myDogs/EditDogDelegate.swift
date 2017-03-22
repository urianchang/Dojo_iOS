//
//  EditDogDelegate.swift
//  myDogs
//
//  Created by Urian Chang on 3/21/17.
//  Copyright © 2017 CodingDojo. All rights reserved.
//

import Foundation
protocol EditDogDelegate: class {
    func itemSaved(by controller: EditDogViewController, with dog: Dog, at: NSIndexPath?)
    func itemCancel(by controller: EditDogViewController)
    func itemDelete(by controller: EditDogViewController, at: NSIndexPath?)
}
