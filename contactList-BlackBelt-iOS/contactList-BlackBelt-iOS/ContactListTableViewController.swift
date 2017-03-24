//
//  ContactListTableViewController.swift
//  contactList-BlackBelt-iOS
//
//  Created by Urian Chang on 3/24/17.
//  Copyright © 2017 CodingDojo. All rights reserved.
//

import UIKit
import Foundation
import CoreData

class ContactListTableViewController: UITableViewController, EditContactDelegate, ShowContactDelegate {

//    var contacts = ["Test 1", "Test 2"]
//    var numbers = ["123", "456"]

    var contacts = [Contact]()
    
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAllItems()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table View Configuration
        // SECTIONS
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
        // ROWS
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return contacts.count
    }
        // CELLS
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath)
        cell.textLabel?.text = contacts[indexPath.row].firstname! + " " + contacts[indexPath.row].lastname!
        cell.detailTextLabel?.text = contacts[indexPath.row].number!
        return cell
    }

    // MARK: - Table Cell Action(s)
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //: ACTION SHEETS TRA-LA-LA-LA~
        let alertController = UIAlertController(title: "For \(contacts[indexPath.row].firstname! + " " + contacts[indexPath.row].lastname!)", message: "What would you like to do?", preferredStyle: .actionSheet)
        let viewButton = UIAlertAction(title: "View", style: .default, handler: {(action)-> Void in
            self.performSegue(withIdentifier: "showContactSegue", sender: indexPath)
        })
        let editButton = UIAlertAction(title: "Edit", style: .default, handler: {(action)->Void in
            self.performSegue(withIdentifier: "editContactSegue", sender: indexPath)
        })
        let deleteButton = UIAlertAction(title: "Delete", style: .destructive, handler: {(action)->Void in
            let contact = self.contacts[indexPath.row]
            self.managedObjectContext.delete(contact)
            self.contacts.remove(at: indexPath.row)
            self.tableView.reloadData()
            self.saveData()
        })
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: {(action)->Void in
            print("Action sheet Cancelled")
        })
        
        alertController.addAction(viewButton)
        alertController.addAction(editButton)
        alertController.addAction(deleteButton)
        alertController.addAction(cancelButton)
        self.navigationController!.present(alertController, animated: true, completion: nil)
    }
    
    // MARK: - Nav Bar Action(s)
    @IBAction func addContactPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "editContactSegue", sender: sender)
    }

    //: EditContactDelegate Functions
    func itemSaved(by controller: EditContactViewController, firstname: String, lastname: String, number: String, indexPath: NSIndexPath?){
//        print ("First name: \(firstname)")
//        print ("Last name: \(lastname)")
//        print ("Number: \(number)")
//        print ("IndexPath: \(indexPath)")
        if let ip = indexPath {
            let contact = contacts[ip.row]
            contact.firstname = firstname
            contact.lastname = lastname
            contact.number = number
        } else {
            let newContact = NSEntityDescription.insertNewObject(forEntityName: "Contact", into: managedObjectContext) as! Contact
            newContact.firstname = firstname
            newContact.lastname = lastname
            newContact.number = number
            contacts.append(newContact)
        }
        saveData()
        tableView.reloadData()
        dismiss(animated: true, completion: nil)
    }
    func cancelPressed(by controller: EditContactViewController){
        dismiss(animated: true, completion: nil)
    }

    //: ShowContactDelegate Functions
    func donePressed(by controller: ShowContactViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Navigation
    //: Segue names: editContactSegue, showContactSegue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editContactSegue" {
            let navigationController = segue.destination as! UINavigationController
            let editContactVC = navigationController.topViewController as! EditContactViewController
            editContactVC.delegate = self
            editContactVC.new = true
            if let senderobj = sender as? NSIndexPath {
                editContactVC.new = false
                editContactVC.firstName = contacts[senderobj.row].firstname
                editContactVC.lastName = contacts[senderobj.row].lastname
                editContactVC.number = contacts[senderobj.row].number
                editContactVC.indexPath = senderobj
            }
        } else if segue.identifier == "showContactSegue" {
            let navigationController = segue.destination as! UINavigationController
            let showContactVC = navigationController.topViewController as! ShowContactViewController
            showContactVC.delegate = self
            if let senderobj = sender as? NSIndexPath {
                showContactVC.name = contacts[senderobj.row].firstname! + " " + contacts[senderobj.row].lastname!
                showContactVC.number = contacts[senderobj.row].number
            }
        }
    }

    //: MARK: - Core Data Functions
    // Fetch all contacts in core data
    func fetchAllItems() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Contact")
        do {
            let result = try managedObjectContext.fetch(request)
            contacts = result as! [Contact]
        } catch {
            print ("\(error)")
        }
    }
    // Save to core data
    func saveData() {
        do {
            try managedObjectContext.save()
        } catch {
            print ("\(error)")
        }
    }
}
