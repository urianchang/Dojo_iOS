//
//  AddWordsViewController.swift
//  MadLibs
//
//  Created by Urian Chang on 3/20/17.
//  Copyright © 2017 CodingDojo. All rights reserved.
//

import UIKit

class AddWordsViewController: UIViewController {
    
    weak var delegate : SubmitWordsDelegate?
    
    @IBOutlet weak var adjectiveTextField: UITextField!
    @IBOutlet weak var verb1TextField: UITextField!
    @IBOutlet weak var verb2TextField: UITextField!
    @IBOutlet weak var nounTextField: UITextField!
    
    @IBAction func submitButtonPressed(_ sender: UIButton) {
        print ("submit pressed")
        let arr = [adjectiveTextField.text, verb1TextField.text, verb2TextField.text, nounTextField.text]
        delegate?.wordSaved(by: self, with: arr as! [String])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
