//
//  ViewController.swift
//  NorthEastSouthWest
//
//  Created by Urian Chang on 3/19/17.
//  Copyright © 2017 CodingDojo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var direction : String?
    
    @IBAction func directionButtonPressed(_ sender: UIButton) {
//        direction = sender.titleLabel!.text
        performSegue(withIdentifier: "showDirectionSegue", sender: sender.titleLabel!.text)
    }
    
    @IBAction func unwindToHome(segue: UIStoryboardSegue) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as? UINavigationController
        let destinationVC = destination?.topViewController as! DirectionViewController
        destinationVC.direction = sender as! String?
    }

}

