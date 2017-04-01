//
//  SongTableViewController.swift
//  Chorus
//
//  Created by Urian Chang on 3/29/17.
//  Copyright © 2017 frandz. All rights reserved.
//

import UIKit
import CoreData

class SongTableViewController: UITableViewController, GameDelegate {
    
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var items = [ChorusItem]()
    
    @IBAction func AddSong(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "musicSegue", sender: nil)
    }
    
    func fetchallitems() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ChorusItem")
        do {
            let result = try managedObjectContext.fetch(request)
            items = result as! [ChorusItem]
        }
        catch { print("\(error)")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchallitems()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "songCell", for: indexPath)
        // Configure the cell...
        cell.textLabel?.text = items[indexPath.row].title
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        managedObjectContext.delete(items[indexPath.row])
        fetchallitems()
        do {
            try managedObjectContext.save()
        }
        catch {
            print("\(error)")
        }
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let alert = UIAlertController(title: "Chorus Namer", message: "Enter your chorus name", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Chorus Name"
        }
        alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0]
            self.items[indexPath.row].title = textField?.text
            do {
                try self.managedObjectContext.save()
            }
            catch {
                print("\(error)")
            }
            self.fetchallitems()
            tableView.reloadData()
            
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "musicSegue", sender: indexPath)
    }
    
    func itemsaved(title: String, instrument: String, tempo: Int16, song: NSObject, indexpath: NSIndexPath?){
        if let ip = indexpath {
            let item = items[ip.row]
            item.song = song
            item.tempo = tempo
        }
        else {
            let item = NSEntityDescription.insertNewObject(forEntityName: "ChorusItem", into: managedObjectContext) as! ChorusItem
            item.title = title
            item.instrument = instrument
            item.tempo = tempo
            item.song = song
            items.append(item)
        }
        do {
            try managedObjectContext.save()
        }
        catch {
            print("\(error)")
        }
        tableView.reloadData()
        print("songtable save")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! GameViewController
        if let senderobj = sender as? NSIndexPath {
            destination.indexPath = senderobj
            let songArray = items[senderobj.row].song as? [Array<Bool>]
            destination.arr = songArray
            destination.tempo = items[senderobj.row].tempo
        }
        destination.delegate = self
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
