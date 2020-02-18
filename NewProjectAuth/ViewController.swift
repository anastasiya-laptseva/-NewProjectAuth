//
//  ViewController.swift
//  NewProjectAuth
//
//  Created by Anastasiya Laptseva on 2/17/20.
//  Copyright © 2020 Anastasiya Laptseva. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    
    static var loginText = ""
    static var passText = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func clickLogin(_ sender: Any) {
        if(CheckLogin(textField: loginTextField)){
            ShowAlert(text: "Invalid login!")
            return
        }
        
        if(CheckPassword(textField: PasswordTextField)){
            ShowAlert(text: "Invalid password!")
            return
        }
        
        ViewController.loginText = loginTextField.text ?? "Incognito"
        ViewController.passText = PasswordTextField.text ?? "Incognito"
        
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let controller = storyboard.instantiateViewController(withIdentifier: "navigation")
        let window = UIApplication.shared.windows.first
        window?.rootViewController = controller
    }
    
    func CheckLogin(textField: UITextField) -> Bool {
        if textField.text?.isEmpty ?? false
        {
            return true
        }
        return false
    }
    
    func CheckPassword(textField: UITextField) -> Bool {
        if textField.text?.count ?? 0 <= 6
        {
            return true
        }
        return false
    }
    
    func ShowAlert(text: String) -> Void {
        let alert = UIAlertController(title: "Error", message: text, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Sorry", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
   
    
    
}

