//
//  SubmitWordsDelegate.swift
//  MadLibs
//
//  Created by Urian Chang on 3/20/17.
//  Copyright © 2017 CodingDojo. All rights reserved.
//

import Foundation

protocol SubmitWordsDelegate: class {
    func wordSaved(by controller: AddWordsViewController, with arr: [String])
}
