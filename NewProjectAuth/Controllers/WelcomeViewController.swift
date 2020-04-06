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
    @IBOutlet weak var pushMeButton: UIButton!
    static var style: Int = 1
    let animationPushButton = AnimationPushButton()
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
    @IBAction func animationButton(_ sender: Any) {
        guard let viewPress = sender as? UIView ?? nil else {
            return
        }
        animationPushButton.pushPress(view: viewPress)
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
