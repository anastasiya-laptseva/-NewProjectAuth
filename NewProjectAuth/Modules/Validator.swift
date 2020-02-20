//
//  Validator.swift
//  NewProjectAuth
//
//  Created by Anastasiya Laptseva on 2/20/20.
//  Copyright © 2020 Anastasiya Laptseva. All rights reserved.
//
import Foundation
import UIKit

class Validator {
    
    func validateTextFieldLetter(textField: UITextField) -> Void {
        let set = NSCharacterSet.init(charactersIn: "ABCDEFGHIJKLMONPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 ").inverted
        
        if var text = textField.text{
            if text.rangeOfCharacter(from: set) ?? nil != nil {
                text.removeLast()
                textField.text = text
            }
        }
        
        
        
    }
    
    func CheckLogin(text: String) -> Bool {
        if text.isEmpty
        {
            return true
        }
        return false
    }
    
//    func CheckLogin2(text: String) -> Bool {
//        if text.
//        {
//            return true
//        }
//        return false
//    }
    
    func CheckPassword(text: String, maxLength: Int) -> Bool {
        if text.count <= maxLength
        {
            return true
        }
        return false
    }
    
    func ShowAlert(text: String, _ sender: Any) -> Void {
        let alert = UIAlertController(title: "Error", message: text, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Sorry", style: UIAlertAction.Style.default, handler: nil))
        (sender as AnyObject).present(alert, animated: true, completion: nil)
    }
    
    

    
    
    
    
    
}
