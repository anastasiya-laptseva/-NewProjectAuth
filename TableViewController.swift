//
//  TableViewController.swift
//  NewProjectAuth
//
//  Created by Anastasiya Laptseva on 2/17/20.
//  Copyright © 2020 Anastasiya Laptseva. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController{
    struct Student {
        var name: String
        var surname: String = "value"
        var age: String = "value"
        var info: String = "value"
        var gender: Gender = .preferNotToSay
        
        enum Gender {
            case mele, female, preferNotToSay
        }
    }

    var students: [Student] = []

    let data = ["Student 1","Student 2","Student 3","Student 4","Student 5","Student 6","Student 7","Student 8","Student 9","Student 10","Student 11","Student 12","Student 13","Student 14","Student 15","Student 16","Student 17","Student 18","Student 19","Student 20"]
    
    override func viewDidLoad() {
       super.viewDidLoad()
       students = prepareArray()
        self.tableView.register(CodeTableViewCell.self, forCellReuseIdentifier: CodeTableViewCell.id)
       tableView.register(UINib(nibName: "XIB", bundle: nil), forCellReuseIdentifier: XIB.id)
   }
    
    func prepareArray() -> [Student] {
        var array: [Student] = []
        guard let path = Bundle.main.path(forResource: "Names", ofType: "txt") else { return array }
        
        var allStudentString: String = " "
        
        do {
            var allStudentString = try String(contentsOfFile: path)
        } catch { }
        
        var splittedNames = allStudentString.split(separator: " ")
        
        splittedNames.forEach { name in
            array.append(Student(name: String(name)))
            
        }
        
        return array
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            students.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell
        if indexPath.row % 3 == 0 {
                cell = tableView.dequeueReusableCell(withIdentifier: "pink", for: indexPath)
            } else {
                cell = tableView.dequeueReusableCell(withIdentifier: "blue", for: indexPath)

            }
            cell.textLabel?.text = data[indexPath.row]
            return cell
    }
//        сделать чтобы каждый третий менял цвет, сделать это через кейс

    func updateData() {
        tableView.reloadData()
    }
}
