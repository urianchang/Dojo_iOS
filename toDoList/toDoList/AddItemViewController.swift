//
//  AddItemViewController.swift
//  toDoList
//
//  Created by Urian Chang on 3/21/17.
//  Copyright © 2017 CodingDojo. All rights reserved.
//

import UIKit
import Foundation
import CoreData

class AddItemViewController: UIViewController {

    @IBOutlet weak var taskTitleTextField: UITextField!
    @IBOutlet weak var taskDetailTextView: UITextView!
    @IBOutlet weak var taskDatePicker: UIDatePicker!
    
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        taskDetailTextView.text = ""
        let borderColor : UIColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.0)
        taskDetailTextView.layer.borderWidth = 0.5
        taskDetailTextView.layer.borderColor = borderColor.cgColor
        taskDetailTextView.layer.cornerRadius = 5.0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func submitPressed(_ sender: UIButton) {
        print ("Task title: \(taskTitleTextField.text)")
        print ("Task detail: \(taskDetailTextView.text)")
        
        //: Format the date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yy"
        let dateStr = dateFormatter.string(from: taskDatePicker.date)
        print ("Task date: \(dateStr)")
        
        let item = NSEntityDescription.insertNewObject(forEntityName: "ItemObject", into: managedObjectContext) as! ItemObject
        item.title = taskTitleTextField!.text
        item.detail = taskDetailTextView!.text
        item.date = dateStr
        item.completed = false
        
        do {
            try managedObjectContext.save()
        } catch {
            print ("\(error)")
        }
    }

}
