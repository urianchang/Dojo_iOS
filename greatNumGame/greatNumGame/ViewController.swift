//
//  ViewController.swift
//  greatNumGame
//
//  Created by Urian Chang on 3/8/17.
//  Copyright © 2017 CodingDojo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // Variables used
    var randNum = Int()
    
    //: Helper function to generate random number from 1 - 100
    func getRandNum() -> Int {
        return Int(arc4random_uniform(100)+1)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        randNum = getRandNum()
    }

    @IBOutlet weak var userInput: UITextField!
    
    @IBAction func submitPressed(_ sender: UIButton) {
        print ("Submit pressed")
        print ("Guess: \(userInput.text); Actual: \(randNum)")
        //Declare variable that will be used in the function
        var userGuess = Int()
        
        //Optional Binding
        if let x = userInput.text {
            //: Only care about integers that are inputted
            if (Int(x) != nil) {
                userGuess = Int(x)!
                if userGuess == randNum {
                    //: Create the alert prompt
                    let alertController = UIAlertController(title: "HOORAY", message: "Your guess of \(userGuess) is correct!", preferredStyle: .alert)
                    let playAgainAction = UIAlertAction(title: "Play Again", style: .default) { action in
                        self.randNum = self.getRandNum()
                        self.userInput.text = ""
                    }
                    alertController.addAction(playAgainAction)
                    self.present(alertController, animated: true, completion: nil)
                } else if userGuess < randNum {
                    //: Create the alert prompt
                    let alertController = UIAlertController(title: "Too Low", message: "Your guess of \(userGuess) is too low!", preferredStyle: .alert)
                    let OKAction = UIAlertAction(title: "OK", style: .default) { action in
                        self.userInput.text = ""
                    }
                    alertController.addAction(OKAction)
                    self.present(alertController, animated: true, completion: nil)
                } else {
                    //: Create the alert prompt
                    let alertController = UIAlertController(title: "Too High", message: "Your guess of \(userGuess) is too high!", preferredStyle: .alert)
                    let OKAction = UIAlertAction(title: "OK", style: .default) { action in
                        self.userInput.text = ""
                    }
                    alertController.addAction(OKAction)
                    self.present(alertController, animated: true, completion: nil)
                }
            } else {
                //: Create alert prompt if something other than an integer is inputted
                let alertController = UIAlertController(title: "Ooops...", message: "Please enter a number.", preferredStyle: .alert)
                let OKAction = UIAlertAction(title: "OK", style: .default) { action in
                    self.userInput.text = ""
                }
                alertController.addAction(OKAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

