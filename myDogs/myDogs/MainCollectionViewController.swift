//
//  MainCollectionViewController.swift
//  myDogs
//
//  Created by Urian Chang on 3/21/17.
//  Copyright © 2017 CodingDojo. All rights reserved.
//

import UIKit
import Foundation
import CoreData

private let reuseIdentifier = "Cell"

class MainCollectionViewController: UICollectionViewController, EditDogDelegate {

    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
//    var items = [1, 2, 3, 4, 5, 6]
    var items = [Dog]()
    
    @IBAction func addPressed(_ sender: UIBarButtonItem) {
        print ("Add Pressed")
        performSegue(withIdentifier: "AddDogSegue", sender: sender)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAllItems()
        print ("ViewDidLoad")
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        //: Commented this line out because it was throwing an error with the custom cell.
//        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "DogCell")
    }

    override func viewWillAppear(_ animated: Bool) {
        print ("ViewWillAppear")
        fetchAllItems()
        collectionView?.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddDogSegue" {
            print ("Taking you to add new dog view")
        } else {
            let navigationController = segue.destination as! UINavigationController
            let editDogViewController = navigationController.topViewController as! EditDogViewController
            editDogViewController.delegate = self
            let indexPath = sender as! NSIndexPath
            let item = items[indexPath.row]
            editDogViewController.item = item
            editDogViewController.indexPath = indexPath
        }
    }

    @IBAction func unwindToHome(segue: UIStoryboardSegue) {
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return items.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DogCell", for: indexPath) as! CustomCell
        cell.dogNameLabel.text = items[indexPath.row].name
        cell.dogProfile.image = UIImage(data: items[indexPath.row].photo as! Data)
        // Configure the cell
        cell.backgroundColor = UIColor.blue
        return cell
    }
    
    func fetchAllItems() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Dog")
        do {
            let result = try managedObjectContext.fetch(request)
            items = result as! [Dog]
        } catch {
            print ("\(error)")
        }
    }
    
    // MARK: UICollectionViewDelegate

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "EditDogSegue", sender: indexPath)
    }
    
    func itemSaved(by controller: EditDogViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    func itemCancel(by controller: EditDogViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}

