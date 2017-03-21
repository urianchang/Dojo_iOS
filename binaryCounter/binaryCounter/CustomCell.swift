//
//  CustomCell.swift
//  binaryCounter
//
//  Created by Urian Chang on 3/20/17.
//  Copyright © 2017 CodingDojo. All rights reserved.
//

import Foundation
import UIKit

protocol CustomCellButtonsDelegate : class {
    func addTapped(cell: CustomCell)
    func subTapped(cell: CustomCell)
}


class CustomCell: UITableViewCell {
    
    var buttonDelegate : CustomCellButtonsDelegate?
    
    @IBOutlet weak var valueLabel: UILabel!
    
    @IBAction func subtractPressed(_ sender: UIButton) {
        buttonDelegate?.subTapped(cell: self)
    }
    
    @IBAction func addPressed(_ sender: UIButton) {
        buttonDelegate?.addTapped(cell: self)
    }
}
