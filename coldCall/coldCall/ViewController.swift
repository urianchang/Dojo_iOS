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
    
    
    @IBAction func ChangeButton(_ sender: Any) {
        changeName()
    }
    
    let nameArr = ["TEST 1", "TEST 2", "TEST 3", "TEST 4", "TEST 5"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        changeName()
    }

    func changeName() {
        let rand = Int(arc4random_uniform(UInt32(nameArr.count)))
        NameLabel.text = nameArr[rand]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

