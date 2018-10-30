//
//  LessonTableViewController.swift
//  keystone Park
//
//  Created by Rajat on 10/30/18.
//  Copyright © 2018 None. All rights reserved.
//

import UIKit

class LessonTableViewController: UITableViewController {
    
    let students = ["Ben", "John"]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    @IBAction func addStudentAction(_ sender: UIBarButtonItem) {
        present(alertController(actionType: "add"), animated: true, completion: nil)
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return students.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "studentCell", for: indexPath)

        cell.textLabel?.text = students[indexPath.row]

        return cell
    }
 
    private func alertController(actionType: String) -> UIAlertController {
        let alertController = UIAlertController(title: "Keystone Park Lesson", message: "Student Info", preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.placeholder = "Name"
            
        }
        alertController.addTextField { (textField) in
            textField.placeholder = "Lesson Type: Ski | Snowboard"
        }
        
        let defaultAction = UIAlertAction(title: actionType.uppercased(), style: .default) { (action) in
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { (action) in
            
        }
        
        alertController.addAction(defaultAction)
        alertController.addAction(cancelAction)
        return alertController
    }

}
