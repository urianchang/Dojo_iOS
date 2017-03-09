//
//  ViewController.swift
//  calculator
//
//  Created by Urian Chang on 3/8/17.
//  Copyright © 2017 CodingDojo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var numLabel: UILabel!
    
    //: Variables used in the app
    var numStr = "" //Holds the number currently being generated
    var numArr = [Any]() //Holds the numbers and operators being processed
    
    //: When a number pad button is pressed
    @IBAction func numpadPressed(_ sender: UIButton) {
        print ("Boop")
        if sender.tag == -1 {
            if !(numStr.contains(".")) {
                numStr += "."
            }
        } else {
            numStr += String(sender.tag)
        }
        numLabel.text = numStr
    }
    
    //: When a special button (e.g. "Clear") is pressed
    @IBAction func spButtonPressed(_ sender: UIButton) {
        if sender.tag == 0 {
            print ("Clear out!")
            numStr = ""
            numArr = []
            numLabel.text = "0"
        }
    }
    
    //: When a math function button is pressed
    @IBAction func mathFuncPressed(_ sender: UIButton) {
        print ("Calculating...")
        if sender.tag == 0 {
            
        } else if sender.tag == 1 {
            
        } else if sender.tag == 2 {
            
        } else if sender.tag == 3 {
            
        } else if sender.tag == 4 {
            
        } else {
            print ("Uh...how did you get this tag?")
        }
    }
    
    
    //: Hide the status bar
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        numLabel.text = "0"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

