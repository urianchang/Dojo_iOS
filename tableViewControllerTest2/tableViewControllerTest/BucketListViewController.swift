//
//  ViewController.swift
//  tableViewControllerTest
//
//  Created by Urian Chang on 3/14/17.
//  Copyright © 2017 CodingDojo. All rights reserved.
//

//: Going to implement Core Data in this version!!

import UIKit
import CoreData

class BucketListViewController: UITableViewController, AddItemTableViewControllerDelegate {

    //    var items = ["Go to Moon", "Eat a candybar", "Swim in the Amazon", "Ride a motorbike in Tokyo"]
    
    var items = [BucketListItem]()
    
    //: Add MOC
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "EditItemSegue", sender: sender)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAllItems()
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
        cell.textLabel?.text = items[indexPath.row].text!
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
        let item = items[indexPath.row]
        managedObjectContext.delete(item)
        
        do {
            try managedObjectContext.save()
        } catch {
            print (error)
        }
        
        items.remove(at: indexPath.row)
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

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
        
        if let senderobj = sender as? NSIndexPath {
            let item = items[senderobj.row]
            addItemTableViewController.item = item.text!
            addItemTableViewController.indexPath = senderobj
        }

    }
    
    func fetchAllItems() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "BucketListItem")
        do {
            let result = try managedObjectContext.fetch(request)
            items = result as! [BucketListItem]
        } catch {
            print ("\(error)")
        }
    }
    
    func cancelButtonPressed(by controller: addItemTableViewController) {
//        print ("I am the hidden controller, but I am responding to the cancel button press on the top view controller.")
        dismiss(animated: true, completion: nil)
    }
    
    func itemSaved(by controller: addItemTableViewController, with text: String, at indexPath: NSIndexPath?) {
//        print ("Received text from top view: \(text)")
        
        if let ip = indexPath {
            let item = items[ip.row]
            item.text = text
        } else {
            let item = NSEntityDescription.insertNewObject(forEntityName: "BucketListItem", into: managedObjectContext) as! BucketListItem
            item.text = text
            items.append(item)
        }
        
        do {
            try managedObjectContext.save()
        } catch {
            print ("\(error)")
        }
        
        
        tableView.reloadData()
        dismiss(animated: true, completion: nil)
    }
}

