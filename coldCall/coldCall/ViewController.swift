//
//  ViewController.swift
//  coldCall
//
//  Created by Urian Chang on 3/7/17.
//  Copyright © 2017 CodingDojo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var NameLabel: UILabel!
    
    @IBOutlet weak var NumLabel: UILabel!
    
    @IBAction func ChangeButton(_ sender: Any) {
        changeUI()
    }
    
    let nameArr = ["TEST 1", "TEST 2", "TEST 3", "TEST 4", "TEST 5"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        NameLabel.text = "READY?"
        NumLabel.isHidden = true
    }

    func changeUI() {
        if NumLabel.isHidden {
            NumLabel.isHidden = false
        }
        let rand = Int(arc4random_uniform(UInt32(nameArr.count)))
        NameLabel.text = nameArr[rand]
        NumLabel.text = String(Int(arc4random_uniform(UInt32(nameArr.count))) + 1)
        if NumLabel.text == "1" || NumLabel.text == "2" {
            NumLabel.textColor = UIColor.red
        } else if NumLabel.text == "3" || NumLabel.text == "4" {
            NumLabel.textColor = UIColor.orange
        } else {
            NumLabel.textColor = UIColor.green
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

