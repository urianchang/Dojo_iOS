//
//  ViewController.swift
//  tabBarController
//
//  Created by Glen Jantz on 3/23/17.
//  Copyright © 2017 Glen Jantz. All rights reserved.
//

import UIKit

class ViewController: UIViewController, tabbardelegate {

    
    @IBOutlet weak var page1Label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nav = self.tabBarController?.viewControllers?[1] as? OtherViewController
        nav?.delegate = self
        
        
        
//         Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.selectedIndex = 1
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func itemsaved(by controller: OtherViewController, text: String) {
        page1Label.text = text
    }
}

