//
//  LessonTableViewController.swift
//  keystone Park
//
//  Created by Rajat on 10/30/18.
//  Copyright © 2018 None. All rights reserved.
//

import UIKit
import CoreData

class LessonTableViewController: UITableViewController {
    
    var moc: NSManagedObjectContext? {
        didSet {
            if let moc = moc {
                lessonService = LessonService(moc: moc)
            }
        }
    }
    
    //MARK: Private
    private var lessonService: LessonService?
    var students: [Student] = []

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

        cell.textLabel?.text = students[indexPath.row].name
        cell.detailTextLabel?.text = students[indexPath.row].lesson?.type

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
        
        let defaultAction = UIAlertAction(title: actionType.uppercased(), style: .default) {[weak self] (action) in
            guard let studentName = alertController.textFields?[0].text, let lessonName = alertController.textFields?[1].text else { return }
            if actionType.caseInsensitiveCompare("add") == .orderedSame {
                if let lessonType = LessonType(rawValue: lessonName.lowercased()) {
                    self?.lessonService?.addStudent(name: studentName, for: lessonType, completion: { (success, students) in
                        self?.students = students
                    })
                }
            }
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { (action) in
            
        }
        
        alertController.addAction(defaultAction)
        alertController.addAction(cancelAction)
        return alertController
    }

}
