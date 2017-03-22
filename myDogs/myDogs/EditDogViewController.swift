//
//  EditDogViewController.swift
//  myDogs
//
//  Created by Urian Chang on 3/21/17.
//  Copyright © 2017 CodingDojo. All rights reserved.
//

import UIKit

class EditDogViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    weak var delegate : EditDogDelegate?
    
    @IBOutlet weak var dogNameTextField: UITextField!
    @IBOutlet weak var dogColorTextField: UITextField!
    @IBOutlet weak var dogTreatTextField: UITextField!
    
    @IBOutlet weak var dogProfiePic: UIImageView!
    
    @IBAction func dogPicPressed(_ sender: UIButton) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    //: UIImagePicker functions
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            dogProfiePic.contentMode = .scaleAspectFit
            dogProfiePic.image = pickedImage
        }
        dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func deletePressed(_ sender: UIButton) {
    }
    
    var item : Dog?
    var indexPath : NSIndexPath?
    
    let imagePicker = UIImagePickerController()
    
    @IBAction func cancelPressed(_ sender: UIBarButtonItem) {
        delegate?.itemCancel(by: self)
    }
    
    @IBAction func savePressed(_ sender: UIBarButtonItem) {
        item?.name = dogNameTextField!.text
        item?.color = dogColorTextField!.text
        item?.treat = dogTreatTextField!.text
        item?.photo = UIImageJPEGRepresentation(dogProfiePic.image!, 1) as NSData?
        delegate?.itemSaved(by: self, with: item!, at: indexPath)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        dogNameTextField.text = item?.name
        dogColorTextField.text = item?.color
        dogTreatTextField.text = item?.treat
        dogProfiePic.image = UIImage(data: item?.photo as! Data)
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
