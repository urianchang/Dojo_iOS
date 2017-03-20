//
//  ViewController.swift
//  MadLibs
//
//  Created by Urian Chang on 3/19/17.
//  Copyright © 2017 CodingDojo. All rights reserved.
//

import UIKit

class ViewController: UIViewController, SubmitWordsDelegate {

    //: Variables used in madlibs
    var adjective : String?
    var verb1 : String?
    var verb2 : String?
    var noun : String?
    
    @IBOutlet weak var madLibsTextLabel: UILabel!
    
    @IBAction func composeButtonPressed(_ sender: UIBarButtonItem) {
        print ("compose button pressed")
//        adjective = nil
//        verb1 = nil
//        verb2 = nil
//        noun = nil
        print ("variables reset to nil")
        performSegue(withIdentifier: "ComposeSegue", sender: sender)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print ("View appears")
        if (adjective != nil && verb1 != nil && verb2 != nil && noun != nil) {
            madLibsTextLabel.text = "We are having a perfectly \(adjective!) time now. Later we will \(verb1!) and \(verb2!) in the \(noun!)."
        } else {
            madLibsTextLabel.text = "..."
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as! UINavigationController
        let AddWordsViewController = navigationController.topViewController as! AddWordsViewController
        AddWordsViewController.delegate = self
    }

    func wordSaved(by controller: AddWordsViewController, with arr: [String]) {
        print ("Array received: \(arr)")
        if arr[0] == "" {
            adjective = nil
        } else {
            adjective = arr[0]
        }
        if arr[1] == "" {
            verb1 = nil
        } else {
            verb1 = arr[1]
        }
        if arr[2] == "" {
            verb2 = nil
        } else {
            verb2 = arr[2]
        }
        if arr[3] == "" {
            noun = nil
        } else {
            noun = arr[3]
        }
        dismiss(animated: true, completion: nil)
    }
    
}

