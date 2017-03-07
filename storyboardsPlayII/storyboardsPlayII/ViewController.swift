//
//  ViewController.swift
//  storyboardsPlayII
//
//  Created by Urian Chang on 3/6/17.
//  Copyright © 2017 CodingDojo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var poem = ["I want to play my storyboards",
                "All over the Apple App store",
                "And let my objects sing a song no one has heard before"]
    var pageCount = 0

    @IBOutlet weak var poemLabel: UILabel!
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        if pageCount < poem.count - 1 {
            pageCount += 1
        } else {
            pageCount = 0
        }
        poemLabel.text = poem[pageCount]
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        poemLabel.text = poem[pageCount]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

