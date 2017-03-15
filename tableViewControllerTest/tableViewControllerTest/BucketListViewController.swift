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
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "EditItemSegue", sender: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        performSegue(withIdentifier: "EditItemSegue", sender: indexPath)
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print ("row selected")
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        //: Default is the delete functionality
        items.remove(at: indexPath.row)
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print ("segue pressed")
        print(sender)
//        if segue.identifier == "AddItemSegue" {
//            print (sender)
//            let navigationController = segue.destination as! UINavigationController
//            let addItemTableViewController = navigationController.topViewController as! addItemTableViewController
//            addItemTableViewController.delegate = self
//        } else if segue.identifier == "EditItemSegue" {
//            print (sender)
//            let navigationController = segue.destination as! UINavigationController
//            let addItemTableViewController = navigationController.topViewController as! addItemTableViewController
//            addItemTableViewController.delegate = self
//            let indexPath = sender as! NSIndexPath
//            let item = items[indexPath.row]
//            addItemTableViewController.item = item
//            addItemTableViewController.indexPath = indexPath
//        }

        let navigationController = segue.destination as! UINavigationController
        let addItemTableViewController = navigationController.topViewController as! addItemTableViewController
        addItemTableViewController.delegate = self
        
        if sender != nil {
            let indexPath = sender as! NSIndexPath
            let item = items[indexPath.row]
            addItemTableViewController.item = item
            addItemTableViewController.indexPath = indexPath
        }

    }
    
    func cancelButtonPressed(by controller: addItemTableViewController) {
        print ("I am the hidden controller, but I am responding to the cancel button press on the top view controller.")
        dismiss(animated: true, completion: nil)
    }
    
    func itemSaved(by controller: addItemTableViewController, with text: String, at indexPath: NSIndexPath?) {
        print ("Received text from top view: \(text)")
        
        if let ip = indexPath {
            items[ip.row] = text
        } else {
            items.append(text)
        }
        tableView.reloadData()
        dismiss(animated: true, completion: nil)
    }
}

