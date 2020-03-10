//
//  ViewController.swift
//  NewProjectAuth
//
//  Created by Anastasiya Laptseva on 2/17/20.
//  Copyright © 2020 Anastasiya Laptseva. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    @IBOutlet weak var sequreIcon: UIButton!
    
    var isSecure: Bool = true
    
    static var loginText = ""
    static var passText = ""
    
    let validator = Validator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func clickSignIn(_ sender: Any) {
        if(validator.CheckLogin(text: loginTextField.text ?? "")){
            validator.ShowAlert(text: "Invalid login! The field must not be empty.", self)
            return
        }
        
        if(validator.CheckPassword(text: PasswordTextField.text ?? "", maxLength: 6)){
            validator.ShowAlert(text: "Invalid password! Password must contain at least 6 characters.", self)
            return
        }
        
        LoginViewController.loginText = loginTextField.text ?? "Incognito"
        LoginViewController.passText = PasswordTextField.text ?? "Incognito"
        
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let controller = storyboard.instantiateViewController(withIdentifier: "navigation")
        let window = UIApplication.shared.windows.first
        window?.rootViewController = controller
    }
    
    @IBAction func EditingChangedLogin(_ sender: Any) {
//        показывает что вводится в поле Login
//        print(loginTextField.text ?? "")
        validator.validateTextFieldLetter(textField: loginTextField)
    }
    @IBAction func EditingChangedPassword(_ sender: Any) {
//        показывает что вводится в поле Password
//        print(PasswordTextField.text ?? "")
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
   
    @IBAction func sequreIconClick(_ sender: Any) {
        isSecure = !isSecure
        PasswordTextField.isSecureTextEntry = isSecure;
        if let image = UIImage(named: isSecure ? "lock (1)" : "lock") as UIImage?{
            sequreIcon.setImage(image, for: .normal)
        }
    }
}
