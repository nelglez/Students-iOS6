//
//  StudentsTableViewController.swift
//  Students
//
//  Created by Nelson Gonzalez on 5/13/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class StudentsTableViewController: UITableViewController {
    
    @IBOutlet weak var sortSegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var filterSegmentedControl: UISegmentedControl!
    
    let studentController = StudentController()
    
    var students: [Student] = [] //Dont filter original array
    
    var editedStudents: [Student] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // This is calling the load... method, and also giving us access to implement the closure, or the code we want to run when the load... method has finished
        studentController.loadFromPersistentStore { (students) in
            self.students = students
            self.editedStudents = students
            
            
            
            // If you are trying to do anything with a `UI` prefixed object, it should be done on the main thread.
            DispatchQueue.main.async {
                self.updateDataSource()
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return editedStudents.count
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StudentCell", for: indexPath)

        let student = editedStudents[indexPath.row]
        
        cell.textLabel?.text = student.name
        cell.detailTextLabel?.text = student.course
       
        return cell
    }
    
    
    private func updateDataSource() {
        //Take the values from segmented controls, then filter/sort the students array baseds on the values.
        
        var editedStudents: [Student]
        
        switch filterSegmentedControl.selectedSegmentIndex {
        case 1:
//            students.filter { (student) -> Bool in
//                return student.course == "iOS"
//            }
            editedStudents = students.filter { $0.course == "iOS"}
            
        case 2:
            editedStudents = students.filter { $0.course == "Web"}
        case 3:
            editedStudents = students.filter { $0.course == "UX"}
            
        default:
            editedStudents = students
        }
        
        if sortSegmentedControl.selectedSegmentIndex == 0 {
            editedStudents = editedStudents.sorted(by: {$0.firstName < $1.firstName})
        } else {
            editedStudents = editedStudents.sorted(by: {$0.lastName < $1.lastName})
        }
        
        self.editedStudents = editedStudents
        
        tableView.reloadData()
    }
    
    @IBAction func sort(_ sender: UISegmentedControl) {
        
        updateDataSource()
        
    }
    
    @IBAction func filter(_ sender: UISegmentedControl) {
        
        updateDataSource()
    }
    
}
