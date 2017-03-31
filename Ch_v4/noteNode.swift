//
//  noteNode.swift
//  Chorus
//
//  Created by Urian Chang on 3/29/17.
//  Copyright © 2017 frandz. All rights reserved.
//

import Foundation
import UIKit

class noteNode {
    var name : String
    var start: (Float, Float)
    var end: (Float, Float)
    var rating: Float
    var comments: [String]
    
    init(name: String, start: (Float, Float), end: (Float, Float), rating: Float, comments: [String]) {
        self.name = name
        self.start = start
        self.end = end
        self.rating = rating
        self.comments = comments
    }
}
