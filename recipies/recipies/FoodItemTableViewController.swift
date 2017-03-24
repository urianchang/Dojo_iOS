//
//  ViewController.swift
//  recipies
//
//  Created by Glen Jantz on 3/23/17.
//  Copyright © 2017 Glen Jantz. All rights reserved.
//

import UIKit
import CoreData

class FoodItemTableViewController: UITableViewController, AddFoodItemDelegate {
    
    
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var items = [FoodItem]()

    override func viewDidLoad() {
        super.viewDidLoad()
           }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
 
    }
    
    func FetchAllFoodItems() {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "FoodItem")
        do {
            let result = try managedObjectContext.fetch(request)
            items = result as! [FoodItem]
        }
        catch {
            print("\(error)")
        }
        
    }
    
    @IBAction func unwind(_ segue: UIStoryboardSegue){}
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row].name
        return cell
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func cancelButtonPressed(by controller: AddFoodItemTableViewController) {
        dismiss(animated: true, completion:  nil)
    }
    
    func saveButtonPressed(by controller: AddFoodItemTableViewController, with text: String, at indexPath: NSIndexPath?) {
        if let ip =  indexPath {
            let item = items[ip.row]
            item.name = text
        }
        else {
            let item = NSEntityDescription.insertNewObject(forEntityName: "FoodItem", into: managedObjectContext) as! FoodItem
            item.name = text
            items.append(item)
        }
        do{
            try managedObjectContext.save()
        }
        catch {
            
        }
        tableView.reloadData()
        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddItem" {
            let nav = segue.destination as! UINavigationController
            let addItem = nav.topViewController as! AddFoodItemTableViewController
            addItem.delegate = self
        }
        else if segue.identifier == "RecipeSegue" {
            let nav = segue.destination as! UINavigationController
            let addItem = nav.topViewController as! RecipeTableController
        }
        else if segue.identifier == "EditItem" {
            let nav = segue.destination as! UINavigationController
            let addItem = nav.topViewController as! AddFoodItemTableViewController
            let indexPath = sender as! NSIndexPath
            let item = items[indexPath.row].name
            addItem.itemtobeedited = item
            addItem.indexPath = indexPath
        }
        
    }
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        performSegue(withIdentifier: "EditItem", sender: indexPath)
    }
}

