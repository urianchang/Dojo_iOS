//
//  MainViewController.swift
//  collectionViewTest
//
//  Created by Urian Chang on 3/27/17.
//  Copyright © 2017 CodingDojo. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var keysTableView: UITableView!
    @IBOutlet weak var notesTableView: UITableView!
    
    /// A simple data structure to populate the table view.
    struct PreviewDetail {
        let title: String
        let preferredHeight: Double
    }
    
    let sampleData = [
        PreviewDetail(title: "Small", preferredHeight: 160.0),
        PreviewDetail(title: "Medium", preferredHeight: 320.0),
        PreviewDetail(title: "Large", preferredHeight: 0.0) // 0.0 to get the default height.
    ]
    
    let sampleData1 = [
        PreviewDetail(title: "One", preferredHeight: 160.0),
        PreviewDetail(title: "Two", preferredHeight: 320.0),
        PreviewDetail(title: "Three", preferredHeight: 0.0), // 0.0 to get the default height.
        PreviewDetail(title: "More", preferredHeight: 0.0) // 0.0 to get the default height.
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        keysTableView.dataSource = self
        keysTableView.delegate = self
        keysTableView.register(UITableViewCell.self, forCellReuseIdentifier: "keysCell")
        
        notesTableView.dataSource = self
        notesTableView.delegate = self
        notesTableView.register(UITableViewCell.self, forCellReuseIdentifier: "notesCell")
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count:Int?
        
        if tableView == self.keysTableView {
            count = sampleData.count
        }
        
        if tableView == self.notesTableView {
            count =  sampleData1.count
        }
        
        return count!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell?
        
        if tableView == self.keysTableView {
            cell = tableView.dequeueReusableCell(withIdentifier: "keysCell", for: indexPath as IndexPath)
            let previewDetail = sampleData[indexPath.row]
            cell!.textLabel!.text = previewDetail.title
            
        }
        
        if tableView == self.notesTableView {
            cell = tableView.dequeueReusableCell(withIdentifier: "notesCell", for: indexPath as IndexPath)
            let previewDetail = sampleData1[indexPath.row]
            cell!.textLabel!.text = previewDetail.title
            
        }
        
        return cell!
    }
    
//    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        
//        var cell:UITableViewCell?
//        
//        if tableView == self.keysTableView {
//            cell = tableView.dequeueReusableCell(withIdentifier: "keysCell", for: indexPath as IndexPath)
//            let previewDetail = sampleData[indexPath.row]
//            cell!.textLabel!.text = previewDetail.title
//            
//        }
//        
//        if tableView == self.notesTableView {
//            cell = tableView.dequeueReusableCell(withIdentifier: "notesCell", for: indexPath as IndexPath)
//            let previewDetail = sampleData1[indexPath.row]
//            cell!.textLabel!.text = previewDetail.title
//            
//        }
//        
//        return cell!
//    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("did select:      \(indexPath.row)  ")
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
