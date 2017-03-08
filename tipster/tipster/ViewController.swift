//
//  ViewController.swift
//  tipster
//
//  Created by Urian Chang on 3/7/17.
//  Copyright © 2017 CodingDojo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var numLabel: UILabel!
    
    var numString = ""
    
    //: Hide the status bar
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        numLabel.text = numString
        groupLabel.text = "Group: 1"
        updateTable()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func numpadPressed(_ sender: UIButton) {
        if sender.tag == -99 {
            numString = ""
        } else {
            if sender.tag == -1 {
                if !(numString.contains(".")) {
                    numString += "."
                } else {
                    numString += ""
                }
            } else {
                numString += String(sender.tag)
            }
        }
        numLabel.text = numString
        updateTable()
    }
    

    let step: Float = 1
    
    //Labels that need to be modified...
    @IBOutlet weak var tipPercLabel1: UILabel!
    @IBOutlet weak var tipPercLabel2: UILabel!
    @IBOutlet weak var tipPercLabel3: UILabel!
    @IBOutlet weak var tipAmtLabel1: UILabel!
    @IBOutlet weak var tipAmtLabel2: UILabel!
    @IBOutlet weak var tipAmtLabel3: UILabel!
    @IBOutlet weak var totalAmtLabel1: UILabel!
    @IBOutlet weak var totalAmtLabel2: UILabel!
    @IBOutlet weak var totalAmtLabel3: UILabel!
    
    var tipPercent: Float = 5
    var groupNum : Float = 1
    
    //: Helper function to update the "table"
    func updateTable() {
        if numString == "" {
            numString = "0"
        }
        //: Yea.. I probably could've made a function or something for this, but lazy.
        // Data for column 1
        let tipAmt1 = (tipPercent/100)*Float(numString)!
        let formattedTip1 = String(format: "$%.2f", tipAmt1)
        let totalAmt1 = (Float(numString)! + tipAmt1)/groupNum
        let formattedAmt1 = String(format: "$%.2f", totalAmt1)
        
        //Data for column 2
        let tipAmt2 = (tipPercent/100*2)*Float(numString)!
        let formattedTip2 = String(format: "$%.2f", tipAmt2)
        let totalAmt2 = (Float(numString)! + tipAmt2)/groupNum
        let formattedAmt2 = String(format: "$%.2f", totalAmt2)
        
        //Data for column 3
        let tipAmt3 = (tipPercent/100*3)*Float(numString)!
        let formattedTip3 = String(format: "$%.2f", tipAmt3)
        let totalAmt3 = (Float(numString)! + tipAmt3)/groupNum
        let formattedAmt3 = String(format: "$%.2f", totalAmt3)
        
        tipPercLabel1.text = "\(tipPercent)%"
        tipPercLabel2.text = "\(tipPercent*2)%"
        tipPercLabel3.text = "\(tipPercent*3)%"
        tipAmtLabel1.text = formattedTip1
        tipAmtLabel2.text = formattedTip2
        tipAmtLabel3.text = formattedTip3
        totalAmtLabel1.text = formattedAmt1
        totalAmtLabel2.text = formattedAmt2
        totalAmtLabel3.text = formattedAmt3
    }
    
    @IBAction func tipSliderChanged(_ sender: UISlider) {
        let roundedValue = round(sender.value / step) * step
        tipPercent = roundedValue
        updateTable()
    }
    
    @IBOutlet weak var groupLabel: UILabel!
    
    @IBAction func groupSliderChanged(_ sender: UISlider) {
        let roundedValue = round(sender.value / step) * step
        groupNum = roundedValue
        let formattedVal = String(format: "%.0f", roundedValue)
        groupLabel.text = "Group: \(formattedVal)"
        updateTable()
    }
    
}

