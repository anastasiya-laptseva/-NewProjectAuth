//
//  ProfileManagerViewController.swift
//  NewProjectAuth
//
//  Created by Anastasiya Laptseva on 2/25/20.
//  Copyright © 2020 Anastasiya Laptseva. All rights reserved.
//

import UIKit

//для сохранения и загрузки данных и создания объекта профайла
class ProfileManager {
    //ключи для сохранения из профайла на редактировании
    enum KeysForSave: String, CaseIterable{
        case empty
        case nameSurname
        case imagePath
        case age
        case gender
        case info
    }
    //ключ для того чтобы знать что профайл создан
    let isProfileKey = "isProfile"
    
    //загрузает профайл из userdefault, возвращает объект структуры студента
    func loadProfile() -> Student? {
        let userDefaults = UserDefaults.standard
        var dictionary = [String:String]()
        for key in KeysForSave.allCases {
            if let value: AnyObject = userDefaults.object(forKey: key.rawValue) as AnyObject?
            {
                dictionary.updateValue(value as! String, forKey: key.rawValue)
            }
        }
        if(dictionary.count>0){
            return Student(object: dictionary)
        }
        return nil
    }
    
    //сохранение в userdefault, принимает объект типа студент
    func saveProfile(student: Student) -> Void {
        let userDefaults = UserDefaults.standard
        userDefaults.set("1", forKey: isProfileKey)
        userDefaults.set("\(student.name) \(student.surname)", forKey: KeysForSave.nameSurname.rawValue)
        userDefaults.set(student.imageName  , forKey: KeysForSave.imagePath.rawValue)
        userDefaults.set(student.age, forKey: KeysForSave.age.rawValue)
        userDefaults.set(student.gender, forKey: KeysForSave.gender.rawValue)
        userDefaults.set(student.info, forKey: KeysForSave.info.rawValue)
        userDefaults.synchronize()
    }
    
    //проверяет создавался ли профайл
    func isProfile() -> Bool {
        let userDefaults = UserDefaults.standard
        if let value: String = userDefaults.object(forKey: isProfileKey) as? String{
            return value == "1"
        }
        
        return false
    }
    
    //очистить сохранения
    func DeleteAll() -> Void {
        let userDefaults = UserDefaults.standard
        userDefaults.removeObject(forKey: isProfileKey)
        userDefaults.removeObject(forKey: KeysForSave.nameSurname.rawValue)
        userDefaults.removeObject(forKey: KeysForSave.imagePath.rawValue)
        userDefaults.removeObject(forKey: KeysForSave.age.rawValue)
        userDefaults.removeObject(forKey: KeysForSave.gender.rawValue)
        userDefaults.removeObject(forKey: KeysForSave.info.rawValue)
    }
}
