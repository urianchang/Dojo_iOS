//
//  ContactListTableViewController.swift
//  contactList-BlackBelt-iOS
//
//  Created by Urian Chang on 3/24/17.
//  Copyright © 2017 CodingDojo. All rights reserved.
//

import UIKit

class ContactListTableViewController: UITableViewController, EditContactDelegate, ShowContactDelegate {

    var contacts = ["Test 1", "Test 2"]
    var numbers = ["123", "456"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK - Table View Configuration
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
        cell.textLabel?.text = contacts[indexPath.row]
        cell.detailTextLabel?.text = numbers[indexPath.row]
        return cell
    }

    // MARK - Table Cell Action(s)
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showContactSegue", sender: indexPath)
    }
    
    
    @IBAction func addContactPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "editContactSegue", sender: sender)
    }

    //: EditContactDelegate Functions
    func itemSaved(by controller: EditContactViewController){
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
        } else if segue.identifier == "showContactSegue" {
            let navigationController = segue.destination as! UINavigationController
            let showContactVC = navigationController.topViewController as! ShowContactViewController
            showContactVC.delegate = self
        }
    }


}
