//
//  ViewController.swift
//  CoreDataRef
//
//  Created by Urian Chang on 3/20/17.
//  Copyright © 2017 CodingDojo. All rights reserved.
//

import UIKit
import Foundation
import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var userInput: UITextField!

    @IBOutlet weak var tableView: UITableView!
    
    var items = [ItemObject]()
    
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        fetchAllItems()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func addPressed(_ sender: UIButton) {
        
        let text = userInput.text!
        
        userInput.text = ""
        
        //: Create new instance of ItemObject
        let item = NSEntityDescription.insertNewObject(forEntityName: "ItemObject", into: managedObjectContext) as! ItemObject

        item.name = text
        
        items.append(item)
        
        tableView.reloadData()
        
        saveData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //: Return an int that indicates how many rows (cells) to draw
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //: Get the UITableViewCell and create/populate it with data then return it
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell")!
        cell.textLabel?.text = items[indexPath.row].name
        return cell
    }
    
    //: Swipe to delete
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        managedObjectContext.delete(items[indexPath.row])
        items.remove(at: indexPath.row) //Remove from items
        tableView.reloadData()
        saveData()
    }
    
    //: Core Data methods
    func fetchAllItems() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ItemObject")
        do {
            let result = try managedObjectContext.fetch(request)
            items = result as! [ItemObject]
            tableView.reloadData()
        } catch {
            print ("\(error)")
        }
    }
    
    func saveData() {
        do {
            try managedObjectContext.save()
        } catch {
            print ("\(error)")
        }
    }
}








