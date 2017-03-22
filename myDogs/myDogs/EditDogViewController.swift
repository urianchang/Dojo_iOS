//
//  EditDogViewController.swift
//  myDogs
//
//  Created by Urian Chang on 3/21/17.
//  Copyright © 2017 CodingDojo. All rights reserved.
//

import UIKit

class EditDogViewController: UIViewController {

    weak var delegate : EditDogDelegate?
    
    @IBOutlet weak var dogNameTextField: UITextField!
    @IBOutlet weak var dogColorTextField: UITextField!
    @IBOutlet weak var dogTreatTextField: UITextField!
    
    @IBOutlet weak var dogProfiePic: UIImageView!
    
    @IBAction func dogPicPressed(_ sender: UIButton) {
    }
    
    @IBAction func deletePressed(_ sender: UIButton) {
    }
    
    var item : Dog?
    var indexPath : NSIndexPath?
    
    @IBAction func cancelPressed(_ sender: UIBarButtonItem) {
        delegate?.itemCancel(by: self)
    }
    
    @IBAction func savePressed(_ sender: UIBarButtonItem) {
        delegate?.itemSaved(by: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dogNameTextField.text = item?.name
        dogColorTextField.text = item?.color
        dogTreatTextField.text = item?.treat
        dogProfiePic.image = UIImage(data: item?.photo as! Data)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
