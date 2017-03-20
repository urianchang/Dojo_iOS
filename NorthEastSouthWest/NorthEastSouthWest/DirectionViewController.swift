//
//  DirectionViewController.swift
//  NorthEastSouthWest
//
//  Created by Urian Chang on 3/19/17.
//  Copyright © 2017 CodingDojo. All rights reserved.
//

import UIKit

class DirectionViewController: UIViewController {
    
    var direction : String?
    
    @IBOutlet weak var mainButtonLabel: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print (direction)
        mainButtonLabel.setTitle(direction, for: UIControlState.normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
