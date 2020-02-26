//
//  ProfileManagerViewController.swift
//  NewProjectAuth
//
//  Created by Anastasiya Laptseva on 2/25/20.
//  Copyright © 2020 Anastasiya Laptseva. All rights reserved.
//

import UIKit

class ProfileManager {
    enum KeysForSave: String, CaseIterable{
        case empty
        case nameSurname
        case imagePath
        case age
        case gender
        case info
    }
    
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
    
    func saveProfile(student: Student) -> Void {
        let userDefaults = UserDefaults.standard
        userDefaults.set(student.name, forKey: KeysForSave.nameSurname.rawValue)
        userDefaults.set(student.imageName  , forKey: KeysForSave.imagePath.rawValue)
        userDefaults.set(student.age, forKey: KeysForSave.age.rawValue)
        userDefaults.set(student.gender, forKey: KeysForSave.gender.rawValue)
        userDefaults.set(student.info, forKey: KeysForSave.info.rawValue)
        userDefaults.synchronize()
    }
}
