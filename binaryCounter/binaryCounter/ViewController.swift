//
//  ViewController.swift
//  binaryCounter
//
//  Created by Urian Chang on 3/20/17.
//  Copyright © 2017 CodingDojo. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, CustomCellButtonsDelegate {

    var total : Int = 0
    
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        totalLabel.text = "Total: \(total)"
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //: Return an int that indicates how many rows (cells) to draw
        return 16
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //: Get the UITableViewCell and create/populate it with data then return it
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell") as! CustomCell
        let val = Int(pow(10.0, Double(indexPath.row)))
        cell.valueLabel.text = "\(val)"
        
        //: Add button delegate for button actions
        cell.buttonDelegate = self
        
        return cell
    }
    
    //: Custom Cell Buttons
    func addTapped(cell: CustomCell) {
        total = total + Int(cell.valueLabel.text!)!
        totalLabel.text = "Total: \(total)"
    }
    
    func subTapped(cell: CustomCell) {
        total = total - Int(cell.valueLabel.text!)!
        totalLabel.text = "Total: \(total)"
    }
}

