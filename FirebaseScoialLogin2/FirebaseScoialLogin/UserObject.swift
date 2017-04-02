//
//  UserObject.swift
//  FirebaseScoialLogin
//
//  Created by Basila Nathan on 3/30/17.
//  Copyright © 2017 Basila Nathan. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

struct UserObject {
    let key: String
    let name: String
    let fbID: Int
    let swipes: [Int: Bool]
    let ref: FIRDatabaseReference?
    
}
