//
//  StudentProfileViewController.swift
//  NewProjectAuth
//
//  Created by Anastasiya Laptseva on 2/20/20.
//  Copyright © 2020 Anastasiya Laptseva. All rights reserved.
//

import UIKit

class StudentProfileViewController: UIViewController {
    
    var student: Student?
    var isEditProfile: Bool?
    
    @IBOutlet weak var labelNameSurname: UILabel!
    @IBOutlet weak var photoImage: UIImageView!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if  let studentCurrent = student{
            photoImage.image = UIImage(named: studentCurrent.imageName)
            labelNameSurname.text = "\(studentCurrent.name) \(studentCurrent.surname)"
            ageLabel.text = "Age: \(studentCurrent.age)"
            genderLabel.text = "Gender: \(studentCurrent.gender)"
            infoLabel.text = "Info: \(studentCurrent.info)"
        }
        
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



//class StudentsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
//
//    var array = [String]()
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        array.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        var cell: UITableViewCell
//            if indexPath.row % 2 == 0 {
//                cell = tableView.dequeueReusableCell(withIdentifier: "red", for: indexPath)
//            } else {
//                cell = tableView.dequeueReusableCell(withIdentifier: "blue", for: indexPath)
//
//            }
//            cell.textLabel?.text = data[indexPath.row]
//            return cell
//    }
//
//
//
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Do any additional setup after loading the view.
//    }
//
//
//
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//    }
//
//
//    func prepareArray() ->  {
//        let path = Bundle.main.path(forResource: "Names", ofType: "txt")
//}
//
//    struct Student {
//        var name: String
//        var surname: String = "value"
//        var age: String = "value"
//        var info: String = "value"
//        var gender: Gender = .preferNotToSay
//
//        enum Gender {
//            case mele, female, preferNotToSay
//        }
//}
//
//
//
//}
// /**/*/
