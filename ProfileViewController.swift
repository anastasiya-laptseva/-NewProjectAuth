//
//  ProfileViewController.swift
//  NewProjectAuth
//
//  Created by Anastasiya Laptseva on 2/17/20.
//  Copyright © 2020 Anastasiya Laptseva. All rights reserved.
//

import UIKit



class ProfileViewController: UIViewController {
    struct Profile {
        var name: String
        var surname: String
        var age: Int
        var email: String
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var profile = Profile.init(name: "Alex", surname: "Laptev", age: 28, email: "free.games.app@gmail.com")
        print(profile.email)
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
