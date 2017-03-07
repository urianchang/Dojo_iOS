//
//  ViewController.swift
//  ninjaGold
//
//  Created by Urian Chang on 3/7/17.
//  Copyright © 2017 CodingDojo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var farmLabel: UILabel!
    
    @IBOutlet weak var caveLabel: UILabel!
    
    @IBOutlet weak var houseLabel: UILabel!
    
    @IBOutlet weak var casinoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        scoreLabel.text = "Score: \(currentScore)"
        houseLabel.isHidden = true
        farmLabel.isHidden = true
        caveLabel.isHidden = true
        casinoLabel.isHidden = true
    }
    
    var currentScore = 0
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func buildingButtonPressed(_ sender: UIButton) {
        houseLabel.isHidden = true
        farmLabel.isHidden = true
        caveLabel.isHidden = true
        casinoLabel.isHidden = true
        if sender.tag == 1 {
            let gold = Int(arc4random_uniform(11))+10
            currentScore += gold
            farmLabel.text = "You got \(gold) gold"
            farmLabel.isHidden = false
        }
        if sender.tag == 2 {
            let gold = Int(arc4random_uniform(6))+5
            currentScore += gold
            caveLabel.text = "You got \(gold) gold"
            caveLabel.isHidden = false
        }
        if sender.tag == 3 {
            let gold = Int(arc4random_uniform(4))+2
            currentScore += gold
            houseLabel.text = "You got \(gold) gold"
            houseLabel.isHidden = false
        }
        if sender.tag == 4 {
            let result = Int(arc4random_uniform(2))
            let gold = Int(arc4random_uniform(51))
            if result == 1 {
                currentScore += gold
                casinoLabel.text = "You got \(gold) gold"
            } else {
                currentScore -= gold
                casinoLabel.text = "You lost \(gold) gold"
            }
            casinoLabel.isHidden = false
            
        }
        scoreLabel.text = "Score: \(currentScore)"
    }

    @IBAction func resetPressed(_ sender: Any) {
        houseLabel.isHidden = true
        farmLabel.isHidden = true
        caveLabel.isHidden = true
        casinoLabel.isHidden = true
        currentScore = 0
        scoreLabel.text = "Score: \(currentScore)"
    }
}

