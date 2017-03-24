//
//  RecipeTableController.swift
//  recipies
//
//  Created by Glen Jantz on 3/23/17.
//  Copyright © 2017 Glen Jantz. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class RecipeTableController: UITableViewController, AddRecipieControllerDelegate {
    
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var recipies = [Recipe]()
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCellium", for: indexPath)
        cell.textLabel?.text = recipies[indexPath.row].name
        return cell
    }
    
    @IBAction func backbutton(_ sender: Any) {
        performSegue(withIdentifier: "Unwind", sender: self)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipies.count
    }
    
    func FetchAllRecipeItems() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Recipe")
        do {
            let result = try managedObjectContext.fetch(request)
            recipies = result as! [Recipe]
        }
        catch {
            print("\(error)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        FetchAllRecipeItems()
    }
    
    func addrecipe(title: String) {
        print("added ")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddRecipe" {
            let destination = segue.destination as! AddRecipieController
            destination.delegate = self
        }
    }
    
    
}
