//
//  ViewController.swift
//  Chorus
//
//  Created by Carolyn Yen on 3/29/17.
//  Copyright © 2017 frandz. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit


class ViewController: UIViewController, NavBarDelegate {
    
    @IBOutlet weak var gameView: UIView!
    
    @IBAction func runPressed(_ sender: UIBarButtonItem) {
        startbutton()
    }
    @IBAction func cancelPressed(_ sender: UIBarButtonItem) {
        cancelbutton()
        
    }
    
    func startbutton() {
        print("start")
    }
    
    func cancelbutton() {
        print("cancel")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let destination = segue.destination as! GameViewController
//        destination.delegate = self
//    }
}
