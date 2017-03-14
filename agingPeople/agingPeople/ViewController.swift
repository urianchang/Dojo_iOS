//
//  ViewController.swift
//  agingPeople
//
//  Created by Urian Chang on 3/13/17.
//  Copyright © 2017 CodingDojo. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //: Table View
    @IBOutlet weak var tableView: UITableView!
    
    var people = ["George", "Betty", "Fran", "Joe", "Helda", "Winifred", "Zed", "Sara", "jeffy", "abraham", "Anna", "Melinda"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.dataSource = self
        tableView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //: What happens when table row is selected
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print ("Section: \(indexPath.section) and Row: \(indexPath.row)")
        people.remove(at: indexPath.row)
        tableView.reloadData()
    }
    
    //: How many cells
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    //: How to create each cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "myTableViewCell", for: indexPath)
        let rand_num = Int(arc4random_uniform(91)+5)
        
        cell.textLabel?.text = people[indexPath.row]
        cell.detailTextLabel?.text = "\(rand_num) years old"
        
        return cell
    }

    

}

