//
//  ViewController.swift
//  toDoList
//
//  Created by Urian Chang on 3/21/17.
//  Copyright © 2017 CodingDojo. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
//    var items = [
//        ["title": "TEST1", "date":"03/12/17", "description":"This is a test cell", "completed":"false"],
//        ["title": "TEST2", "date":"03/14/17", "description":"This is another test cell", "completed":"true"],
//        ]

    var items = [ItemObject]()
    
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func fetchAllItems() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ItemObject")
        do {
            let result = try managedObjectContext.fetch(request)
            items = result as! [ItemObject]
        } catch {
            print ("\(error)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        fetchAllItems()
    }

    override func viewWillAppear(_ animated: Bool) {
        print ("View will appear")
        fetchAllItems()
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //: Return an int that indicates how many rows (cells) to draw
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //: Get the UITableViewCell and create/populate it with data then return it
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell") as! CustomCell
        cell.dateLabel.text = items[indexPath.row].date
        cell.taskTitleLabel.text = items[indexPath.row].title
        cell.taskDetailLabel.text = items[indexPath.row].detail
        
        if items[indexPath.row].completed {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        items[indexPath.row].completed = !(items[indexPath.row].completed)
        saveData()
        tableView.reloadData()
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        managedObjectContext.delete(items[indexPath.row])
        items.remove(at: indexPath.row)
        saveData()
        tableView.reloadData()
    }
    
    @IBAction func unwindToHome(segue: UIStoryboardSegue) {
    }
    
    func saveData() {
        do {
            try managedObjectContext.save()
        } catch {
            print ("\(error)")
        }
    }
}

