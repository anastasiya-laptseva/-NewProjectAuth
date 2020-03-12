//
//  WelcomeViewController.swift
//  NewProjectAuth
//
//  Created by Anastasiya Laptseva on 2/18/20.
//  Copyright © 2020 Anastasiya Laptseva. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    @IBOutlet weak var welcomeLabel: UILabel!
    static var style: Int = 1
//    static var myProfile : Student?
    override func viewDidLoad() {
        super.viewDidLoad()

        welcomeLabel.text = "Welcome, \(LoginViewController.loginText)!"
        // Do any additional setup after loading the view.
    }
    @IBAction func changeStyle(_ sender: Any) {
        guard let segment = sender as? UISegmentedControl else {
            return
        }
        WelcomeViewController.style = segment.selectedSegmentIndex+1
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
