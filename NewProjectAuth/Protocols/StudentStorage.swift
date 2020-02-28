//
//  StudentStorage.swift
//  NewProjectAuth
//
//  Created by Anastasiya Laptseva on 2/25/20.
//  Copyright © 2020 Anastasiya Laptseva. All rights reserved.
//

import UIKit

//для окна работы со списком студентов и для профайта
class StudentStorage : NSObject, UITableViewDataSource{
    //Все студенты
    var students = [Student]()
    
    //Массив цветов
    let genderPrototypes = [GenderPrototype(bacgkroundColor: UIColor(rgb: 0xFEFC9B)), GenderPrototype(bacgkroundColor: UIColor(rgb: 0xEABFEB)), GenderPrototype(bacgkroundColor: UIColor(rgb: 0x76D6FF))]
    
    //указывает количество ячееек которые должны быть созданы
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return students.count
    }
    
    
    //построение ячеек из массива "students"
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //создается новая ячейка
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
    
    //удаление ячейки без сохранения
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //удаление из локального массива
            students.remove(at: indexPath.row)
            //удаление из tableview
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    //загружает студентов из json файла Student.json
    func loadStudents() -> Void{
        let jsonManager = JsonManager()
        let dataJson = jsonManager.LoadFileAsString(name: "Student", type: "json")
        //делаем json объект
        let json = try? JSONSerialization.jsonObject(with: dataJson, options: [])
        if let recipe = json as? [String: Any] {
            //берем массив студентов по данному ключу
            if let array = recipe["students"] as? Array<[String:String]>{
                students = [Student]()
                //заносим всех студентов в students
                for element in array {
                    let student = Student(object: element)
                    students.append(student)
                }
            }
        }
    }
    
    
    func getGenderInt(value: Int) -> Gender {
        switch value {
            case 0:
                return Gender.male
            case 1:
                return Gender.female
            case 2:
                return Gender.preferNotToSay
            default:
                return Gender.male
        }
    }
    
    func getIntGender(value: Gender) -> Int {
        switch value {
            case .male:
                return 0
            case .female:
                return 1
            case .preferNotToSay:
                return 2
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
    
    //коснтруктор для создание студента по значениям в параметрах
    init(imageName: String, name: String, surname: String, age: String, info: String, gender: String){
        self.imageName = imageName
        self.name = name
        self.surname = surname
        self.age = age
        self.info = info
        self.gender = gender
    }
    
    //конструктор, который парсит словарь значений студента
    init(object: [String: String]) {
        if let path =  object["imagePath"]{
            //для профайла из userdefaults
            imageName = path
        }
        else{
            //для студентов из json
            imageName = object["imageName"] ?? ""
        }
        if let fullName = object["nameSurname"]{
            //для профайла, так как сохраняется из поля textfield
            //строка делится на массив подстрок, разделитель пробел
            let fullNameArr = fullName.split{$0 == " "}.map(String.init)
            //для имени берем первое значение массива
            name = fullNameArr.count>0 ? fullNameArr[0] : ""
            //для фамилии второе
            surname = fullNameArr.count>1 ? fullNameArr[1] : ""
        }
        else{
            //для студентов из json
            name = object["name"] ?? ""
            surname = object["surname"] ?? ""
        }
        
        age = object["age"] ?? ""
        info = object["info"] ?? ""
        gender = object["gender"] ?? ""
    }
    
    //так как у нас в структуре gender - это String, здесь преобразование String в Gender enum
    func getGender() -> Gender {
        return Gender(rawValue: gender) ?? Gender.preferNotToSay
    }
}


//прототип для задания цвета ячейки студентов
struct GenderPrototype{
    var bacgkroundColor: UIColor
}

