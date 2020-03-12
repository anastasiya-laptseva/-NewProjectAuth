//
//  TableViewController.swift
//  NewProjectAuth
//
//  Created by Anastasiya Laptseva on 2/17/20.
//  Copyright © 2020 Anastasiya Laptseva. All rights reserved.
//

import UIKit

class ClassTableViewController: UITableViewController {
    //Все студенты
    var students = [Student]()
    //Массив цветов
    var genderPrototypes = [GenderPrototype]()

    let segueProfileID = "profileSeque"
    let segueStudentId = "studentProfile"
    var selectedStudent: Student?
    var selectedColor: UIColor?
    override func viewDidLoad() {
        super.viewDidLoad()
        genderPrototypes.append(GenderPrototype(bacgkroundColor: UIColor(rgb: 0xFEFC9B)))
        genderPrototypes.append(GenderPrototype(bacgkroundColor: UIColor(rgb: 0xEABFEB)))
        genderPrototypes.append(GenderPrototype(bacgkroundColor: UIColor(rgb: 0x76D6FF)))
        loadStudents()
        tableView.dataSource = self
        tableView.reloadData()
   }
    func setStudents(students: [Student]) {
        self.students = students
    }
    func getStudents() -> [Student] {
        return students
    }
    func getGenderPrototypes() -> [GenderPrototype] {
        return genderPrototypes
    }
    func updateData() {
        tableView.reloadData()
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedStudent = getStudents()[indexPath.row]
        selectedColor = tableView.cellForRow(at: indexPath)?.backgroundColor ?? .white
        self.performSegue(withIdentifier: segueStudentId, sender: self)
    }
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == segueStudentId {
            guard let studentProfile = segue.destination as? ProfileViewController ?? nil else {
                return
            }
            studentProfile.student = selectedStudent
            //обозначем для общего окна профайл что работаем со студентами а не с профайлом
            studentProfile.isStudent = true
            studentProfile.color = selectedColor
        }
    }
}
