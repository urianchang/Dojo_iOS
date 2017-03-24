//
//  EditContactViewController.swift
//  contactList-BlackBelt-iOS
//
//  Created by Urian Chang on 3/24/17.
//  Copyright © 2017 CodingDojo. All rights reserved.
//

import UIKit

class EditContactViewController: UIViewController {

    weak var delegate: EditContactDelegate?
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var numberTextField: UITextField!
    
    var firstName : String?
    var lastName : String?
    var number : String?
    var indexPath : NSIndexPath?
    var new : Bool?
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        delegate?.cancelPressed(by: self)
    }
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        let fname = firstNameTextField.text!
        let lname = lastNameTextField.text!
        let number = numberTextField.text!
        delegate?.itemSaved(by: self, firstname: fname, lastname: lname, number: number, indexPath: indexPath)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if new! {
            self.title = "Add Contact"
        } else {
            self.title = "Edit Contact"
        }
        firstNameTextField.text = firstName
        lastNameTextField.text = lastName
        numberTextField.text = number
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
