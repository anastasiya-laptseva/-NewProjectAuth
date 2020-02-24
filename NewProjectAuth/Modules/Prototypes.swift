//
//  Prototypes.swift
//  NewProjectAuth
//
//  Created by Anastasiya Laptseva on 2/23/20.
//  Copyright © 2020 Anastasiya Laptseva. All rights reserved.
//

import UIKit

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
