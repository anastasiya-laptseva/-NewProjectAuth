//
//  TableViewController.swift
//  NewProjectAuth
//
//  Created by Anastasiya Laptseva on 2/17/20.
//  Copyright © 2020 Anastasiya Laptseva. All rights reserved.
//

import UIKit

class ClassTableViewController: UITableViewController{
    let segueProfileID = "profileSeque"
    let segueStudentId = "studentProfile"
    let storageDataSource = StudentStorage()
    
    var selectedStudent: Student?
    var selectedColor: UIColor?
    
    
    
    override func viewDidLoad() {
       super.viewDidLoad()
        storageDataSource.loadStudents()
        tableView.dataSource = storageDataSource
        tableView.reloadData()
   }
    
    func updateData() {
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedStudent = storageDataSource.students[indexPath.row]
        selectedColor = tableView.cellForRow(at: indexPath)?.backgroundColor ?? .white
        self.performSegue(withIdentifier: segueStudentId, sender: self)
    }
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == segueStudentId{
            let studentProfile = segue.destination as! ProfileViewController
            studentProfile.student = selectedStudent
            //обозначем для общего окна профайл что работаем со студентами а не с профайлом
            studentProfile.isStudent = true
            studentProfile.color = selectedColor
        }
    }
    
    
}
