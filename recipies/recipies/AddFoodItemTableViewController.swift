//
//  AddFoodItemTableViewController.swift
//  recipies
//
//  Created by Glen Jantz on 3/23/17.
//  Copyright © 2017 Glen Jantz. All rights reserved.
//

import Foundation
import UIKit

class AddFoodItemTableViewController: UIViewController {
    
    var delegate: AddFoodItemDelegate?
    var itemtobeedited: String?
    var indexPath: NSIndexPath?
    
    @IBOutlet weak var AddItemLabel: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AddItemLabel.text = itemtobeedited
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func cancelPressed(_ sender: UIBarButtonItem) {
        print("hjhjh")
        self.delegate?.cancelButtonPressed(by: self)
    }
    
    @IBAction func savePressed(_ sender: UIBarButtonItem) {
        let text = AddItemLabel.text!
        delegate?.saveButtonPressed(by: self, with: text, at: indexPath)
    }
}
