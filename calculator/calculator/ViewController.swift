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
    var numArr = [String]() //Holds the numbers and operators being processed
    var positive = true //Keeps track of whether or not the number is positive
    
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
            positive = true
            numLabel.text = "0"
        } else if sender.tag == 1 {
            if positive {
                numStr = "-" + numStr
                numLabel.text = numStr
            } else {
                numStr.remove(at: numStr.startIndex)
                numLabel.text = numStr
            }
            positive = !(positive)
        } else if sender.tag == 2 {
            var num = Double(numStr)!
            num /= 100
            numStr = String(num)
            numLabel.text = numStr
        }
    }
    
    //: When a math function button is pressed
    @IBAction func mathFuncPressed(_ sender: UIButton) {
        if sender.tag == 0 {
            print ("NUMBER CRUNCHER")
            if numArr.count != 0 {
                numArr.append(numStr)
                var num = Double()
                var count = 0
                num = Double(numArr[count])!
                count += 1
                while count < numArr.count {
                    if numArr[count] == "+" {
                        num += Double(numArr[count+1])!
                    } else if numArr[count] == "-" {
                        num -= Double(numArr[count+1])!
                    } else if numArr[count] == "*" {
                        num *= Double(numArr[count+1])!
                    } else if numArr[count] == "/" {
                        num /= Double(numArr[count+1])!
                    }
                    count += 2
                }
                numStr = String(num)
                numLabel.text = numStr
            }
        } else if sender.tag == 1 {
            print ("TIME TO ADD")
            numArr.append(numStr)
            numStr = ""
            numArr.append("+")
        } else if sender.tag == 2 {
            print ("TIME TO SUBTRACT")
            numArr.append(numStr)
            numStr = ""
            numArr.append("-")
        } else if sender.tag == 3 {
            print ("TIME TO MULTIPLY ;)")
            numArr.append(numStr)
            numStr = ""
            numArr.append("*")
        } else if sender.tag == 4 {
            print ("TIME TO DIVIDE")
            numArr.append(numStr)
            numStr = ""
            numArr.append("/")
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

