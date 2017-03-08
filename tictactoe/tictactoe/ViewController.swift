//
//  ViewController.swift
//  tictactoe
//
//  Created by Urian Chang on 3/7/17.
//  Copyright © 2017 CodingDojo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var winnerLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        gameStart()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    var game_status = Bool()
    var player1 = Bool()
    var p1Arr = [Int]()
    var p2Arr = [Int]()
    var board = [0, 1, 2, 3, 4, 5, 6, 7, 8]
    var turns = Int()
    var winCombos = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
    
    func gameStart() {
        winnerLabel.isHidden = true
        game_status = true
        player1 = true
        turns = 1
        p1Arr = []
        p2Arr = []
        board = [0, 1, 2, 3, 4, 5, 6, 7, 8]
    }

    @IBOutlet var tileButton: [UIButton]!
    
    
    @IBAction func tilePressed(_ sender: UIButton) {

        if game_status {
            if p1Arr.contains(sender.tag) || p2Arr.contains(sender.tag) {
                print ("Block has been chosen already")
            } else {
                turns += 1
                print ("Turn: \(turns)")
                print ("Tile selected: \(sender.tag)")
                if player1 {
                    sender.backgroundColor = UIColor.red
                    p1Arr.append(sender.tag)
                    print (p1Arr)
                    for combo in winCombos {
                        if p1Arr.contains(combo[0]) && p1Arr.contains(combo[1]) && p1Arr.contains(combo[2]) {
                            game_status = false
                            winnerLabel.text = "P1 wins!"
                            winnerLabel.isHidden = false
                        }

                    }
                } else {
                    sender.backgroundColor = UIColor.blue
                    p2Arr.append(sender.tag)
                    print (p2Arr)
                    for combo in winCombos {
                        if p2Arr.contains(combo[0]) && p2Arr.contains(combo[1]) && p2Arr.contains(combo[2]) {
                            game_status = false
                            winnerLabel.text = "P2 wins!"
                            winnerLabel.isHidden = false
                        }
                    }
                }
                player1 = !(player1)
            }
            if game_status && turns > 9 {
                game_status = false
                winnerLabel.text = "STALEMATE"
                winnerLabel.isHidden = false
            }
        }
    }


    @IBAction func resetButtonPressed(_ sender: Any) {
        print ("RESET")
        gameStart()
        for button in tileButton {
            button.backgroundColor = UIColor.lightGray
        }
    }
}

