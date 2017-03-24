//
//  ShowContactViewController.swift
//  contactList-BlackBelt-iOS
//
//  Created by Urian Chang on 3/24/17.
//  Copyright © 2017 CodingDojo. All rights reserved.
//

import UIKit

class ShowContactViewController: UIViewController {
    
    weak var delegate : ShowContactDelegate?
    
    var name : String?
    var number : String?
    
    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
        delegate?.donePressed(by: self)
    }
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = name
        nameLabel.text = "Name: \(name!)"
        phoneLabel.text = "Number: \(number!)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
