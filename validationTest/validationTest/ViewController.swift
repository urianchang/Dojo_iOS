//
//  ViewController.swift
//  validationTest
//
//  Created by Urian Chang on 3/23/17.
//  Copyright © 2017 CodingDojo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBAction func submitButton(_ sender: UIButton) {
        let status = isValid()
        print (status)
    }
    
    //: Helper function for validation check
    func isValid() -> Bool {
        if textField.text == "" {
            let alertController = UIAlertController(title: "ERROR", message: "Please input text", preferredStyle: .alert)
            
            let OKAction = UIAlertAction(title: "OK", style: .default) { action in
                self.textField.text = ""
            }
            
            alertController.addAction(OKAction)
            
            self.present(alertController, animated: true, completion: nil)

            return false
        }

        return true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

