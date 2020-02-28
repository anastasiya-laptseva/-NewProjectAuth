//
//  FileManager.swift
//  NewProjectAuth
//
//  Created by Anastasiya Laptseva on 2/24/20.
//  Copyright © 2020 Anastasiya Laptseva. All rights reserved.
//

import UIKit

class JsonManager {
    //передаем название и формат файла который находится в проекте и получаем данные в виде байтов
    func LoadFileAsString(name: String, type: String) -> Data
    {
        if let path = Bundle.main.path(forResource: name, ofType: type)
        {
            let fm = FileManager()
            let exists = fm.fileExists(atPath: path)
            if(exists){
                return fm.contents(atPath: path) ?? Data.init()
            }
        }
        
        return Data.init()
    }
}
