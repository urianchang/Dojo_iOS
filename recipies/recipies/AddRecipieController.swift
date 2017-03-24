//
//  AddRecipieController.swift
//  recipies
//
//  Created by Glen Jantz on 3/23/17.
//  Copyright © 2017 Glen Jantz. All rights reserved.
//

import Foundation
import UIKit

protocol AddRecipieControllerDelegate: class {
    func addrecipe(title: String)
}

class AddRecipieController: UIViewController {
    var delegate: AddRecipieControllerDelegate?
    
    @IBOutlet weak var TitleField: UITextField!
    @IBOutlet weak var FoodField1: UITextField!
    @IBOutlet weak var FoodField2: UITextField!
    @IBOutlet weak var FoodField3: UITextField!
    
    @IBAction func AddButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TitleField.placeholder = "Recipe Title"
        FoodField1.placeholder = "Food 1"
        FoodField2.placeholder = "Food 2"
        FoodField3.placeholder = "Food 3"
    }
    
}
