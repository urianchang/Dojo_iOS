//
//  EditContactDelegate.swift
//  contactList-BlackBelt-iOS
//
//  Created by Urian Chang on 3/24/17.
//  Copyright © 2017 CodingDojo. All rights reserved.
//

import Foundation
protocol EditContactDelegate: class {
    func itemSaved(by controller: EditContactViewController)
    func cancelPressed(by controller: EditContactViewController)
}
