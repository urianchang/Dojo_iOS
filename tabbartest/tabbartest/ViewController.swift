//
//  ViewController.swift
//  tabbartest
//
//  Created by Glen Jantz on 3/21/17.
//  Copyright © 2017 Glen Jantz. All rights reserved.
//

import UIKit

protocol TabBarDelegate: class {
    func saveitem(by controller: OtherViewController, text: String)
    
}


class ViewController: UIViewController, TabBarDelegate {
    



    @IBOutlet weak var firstpagelabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let nav = self.tabBarController?.viewControllers?[1] as? OtherViewController
        nav?.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func saveitem(by controller: OtherViewController, text: String) {
        let nav = self.tabBarController?.viewControllers?[1] as? OtherViewController
        nav?.secondpagelabel.text = text
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("FirstViewController viewWillAppear")
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        
        let optionMenu = UIAlertController(title: nil, message: "Choose Option", preferredStyle: .actionSheet)
        
        // 2
        let deleteAction = UIAlertAction(title: "Delete", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            print("File Deleted")
        })
        let saveAction = UIAlertAction(title: "Save", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.tabBarController?.selectedIndex = 1
            print("File Saved")
        })
        
        //
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {
            (alert: UIAlertAction!) -> Void in
            print("Cancelled")
        })
        
        
        // 4
        optionMenu.addAction(deleteAction)
        optionMenu.addAction(saveAction)
        optionMenu.addAction(cancelAction)
        
        // 5
        self.present(optionMenu, animated: true, completion: nil)
        
    }
}

