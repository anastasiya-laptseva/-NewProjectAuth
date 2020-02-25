//
//  StudentStorage.swift
//  NewProjectAuth
//
//  Created by Anastasiya Laptseva on 2/25/20.
//  Copyright © 2020 Anastasiya Laptseva. All rights reserved.
//

import UIKit

class StudentStorage : NSObject, UITableViewDataSource{
    var students = [Student]()
    
    let genderPrototypes = [GenderPrototype(bacgkroundColor: UIColor(rgb: 0xFEFC9B)), GenderPrototype(bacgkroundColor: UIColor(rgb: 0xEABFEB)), GenderPrototype(bacgkroundColor: UIColor(rgb: 0x76D6FF))]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return students.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let student = students[indexPath.row]
        switch student.getGender() {
            case .male:
                cell.backgroundColor = genderPrototypes[2].bacgkroundColor
                break
            case .female:
                cell.backgroundColor = genderPrototypes[1].bacgkroundColor
                break
            case .preferNotToSay:
                cell.backgroundColor = genderPrototypes[0].bacgkroundColor
                break
        }
        cell.textLabel?.text =  "\(student.name) \(student.surname)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            students.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func loadStudents() -> Void{
        let jsonManager = JsonManager()
        let dataJson = jsonManager.LoadFileAsString(name: "Student", type: "json")
        let json = try? JSONSerialization.jsonObject(with: dataJson, options: [])
        if let recipe = json as? [String: Any] {
            if let array = recipe["students"] as? Array<[String:String]>{
                students = [Student]()
                for element in array {
                    let student = Student(object: element)
                    students.append(student)
                }
            }
        }
    }
}

enum Gender: String {
    case male = "male"
    case female = "female"
    case preferNotToSay = "preferNotToSay"
}

struct Student {
    var imageName: String = ""
    var name: String = ""
    var surname: String = ""
    var age: String = ""
    var info: String = ""
    var gender: String = ""
    
    init(object: [String: String]) {
        imageName = object["imageName"] ?? ""
        name = object["name"] ?? ""
        surname = object["surname"] ?? ""
        age = object["age"] ?? ""
        info = object["info"] ?? ""
        gender = object["gender"] ?? ""
    }
    
    func getGender() -> Gender {
        return Gender(rawValue: gender) ?? Gender.preferNotToSay
    }
}


struct GenderPrototype{
    var bacgkroundColor: UIColor
}

