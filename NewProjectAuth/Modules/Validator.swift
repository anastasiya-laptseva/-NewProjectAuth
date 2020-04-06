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
    func validateTextFieldLetter(textField: UITextField) {
        // swiftlint:disable all
        let set = NSCharacterSet.init(charactersIn: "ABCDEFGHIJKLMONPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 ").inverted
        // swiftlint:enable all
        if var text = textField.text {
            if text.rangeOfCharacter(from: set) ?? nil != nil {
                text.removeLast()
                textField.text = text
            }
        }
    }
    func checkLogin(text: String) -> Bool {
        if text.isEmpty {
            return true
        }
        return false
    }
    func checkPassword(text: String, maxLength: Int) -> Bool {
        if text.count < maxLength {
            return true
        }
        return false
    }
    func showAlert(text: String, _ sender: Any) {
        let alert = UIAlertController(title: "Error", message: text, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Sorry", style: UIAlertAction.Style.default, handler: nil))
        (sender as AnyObject).present(alert, animated: true, completion: nil)
    }
}
