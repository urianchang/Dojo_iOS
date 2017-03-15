//
//  ViewController.swift
//  tableViewControllerTest
//
//  Created by Urian Chang on 3/14/17.
//  Copyright © 2017 CodingDojo. All rights reserved.
//

import UIKit

class BucketListViewController: UITableViewController, AddItemTableViewControllerDelegate {
    var items = ["Go to Moon", "Eat a candybar", "Swim in the Amazon", "Ride a motorbike in Tokyo"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print ("Loaded")
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listItemCell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as! UINavigationController
        let addItemTableViewController = navigationController.topViewController as! addItemTableViewController
        addItemTableViewController.delegate = self
    }
    
    func cancelButtonPressed(by controller: addItemTableViewController) {
        print ("I am the hidden controller, but I am responding to the cancel button press on the top view controller.")
        dismiss(animated: true, completion: nil)
    }
    
    func itemSaved(by controller: addItemTableViewController, with text: String) {
        print ("Received text from top view: \(text)")
        items.append(text)
        tableView.reloadData()
        dismiss(animated: true, completion: nil)
    }
}

