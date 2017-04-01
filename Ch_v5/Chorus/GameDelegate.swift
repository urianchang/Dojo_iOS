//
//  GameDelegate.swift
//  Chorus
//
//  Created by Carolyn Yen on 3/30/17.
//  Copyright © 2017 frandz. All rights reserved.
//

import Foundation
import UIKit

protocol GameDelegate: class {
    
    func itemsaved(title: String, instrument: String, tempo: Int16, song: NSObject, indexpath: NSIndexPath?)
    
}
