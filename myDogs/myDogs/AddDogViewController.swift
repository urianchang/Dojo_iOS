//
//  AddDogViewController.swift
//  myDogs
//
//  Created by Urian Chang on 3/21/17.
//  Copyright © 2017 CodingDojo. All rights reserved.
//

import UIKit
import Foundation
import CoreData

class AddDogViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    let imagePicker = UIImagePickerController()
    
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var dogNameTextField: UITextField!
    
    @IBOutlet weak var dogColorTextField: UITextField!
    
    @IBOutlet weak var dogTreatTextField: UITextField!
    
    @IBOutlet weak var dogImageView: UIImageView!
    
    @IBAction func dogImagePressed(_ sender: UIButton) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    //: UIImagePicker functions
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            dogImageView.contentMode = .scaleAspectFit
            dogImageView.image = pickedImage
        }
        dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addDogPressed(_ sender: UIButton) {
        let item = NSEntityDescription.insertNewObject(forEntityName: "Dog", into: managedObjectContext) as! Dog
        item.name = dogNameTextField!.text
        item.color = dogColorTextField!.text
        item.treat = dogTreatTextField!.text
        item.photo = UIImageJPEGRepresentation(dogImageView.image!, 1) as NSData?
        saveData()
        print ("New dog saved")
    }
    
    func saveData() {
        do {
            try managedObjectContext.save()
        } catch {
            print ("\(error)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        dogImageView.layer.borderColor = UIColor.black.cgColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
