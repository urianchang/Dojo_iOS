//
//  ItemViewController.swift
//  tabBarPractice
//
//  Created by Urian Chang on 3/23/17.
//  Copyright © 2017 CodingDojo. All rights reserved.
//

import UIKit

class ItemViewController: UIViewController {

    var delegate : ItemViewControllerDelegate?
    
    @IBAction func cancelPressed(_ sender: UIBarButtonItem) {
        delegate?.itemCancel(by: self)
    }
    
    @IBAction func savePressed(_ sender: UIBarButtonItem) {
        delegate?.itemSaved(by: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "TEST"
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
