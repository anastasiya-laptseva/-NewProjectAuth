//
//  StudentProfileViewController.swift
//  NewProjectAuth
//
//  Created by Anastasiya Laptseva on 2/20/20.
//  Copyright © 2020 Anastasiya Laptseva. All rights reserved.
//

import UIKit

class ProfifeCameraGallery: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var profileView: UIView!
    
    //MARK: PreviewComponents
    @IBOutlet weak var labelNameSurname: UILabel!
    @IBOutlet weak var photoImage: UIImageView!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    
    //MARK: EditComponents
    @IBOutlet weak var nameSurnameEdit: UITextField!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var photoButton: UIButton!
    @IBOutlet weak var ageEdit: UITextField!
    @IBOutlet weak var genderEdit: UISegmentedControl!
    @IBOutlet weak var infoEdit: UITextField!
    
    //MARK: Variables
    var student: Student?
    var color: UIColor?
    var isEditProfile: Bool?
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let colorView = color{
            profileView.backgroundColor = colorView
        }
        
        ShowComponents()
        if(isEditProfile == false){
            LoadProfile()
        }
        else{
            
        }
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func changeGender(_ sender: Any) {
        print(genderEdit.selectedSegmentIndex)
    }
    
    @IBAction func galleryClick(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            print("Button capture")

            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = false

            present(imagePicker, animated: true, completion: nil)
        }
    }
    @IBAction func photoClick(_ sender: Any) {
        if(UIImagePickerController .isSourceTypeAvailable(.camera)){
            imagePicker.sourceType = .camera
            self.present(imagePicker, animated: true, completion: nil)
        }
        else{
            print("Camera is not Available")
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("\(info)")
        if let image = info[.originalImage] as? UIImage {
            photoImage.image = image
            dismiss(animated: true, completion: nil)
        }
    }
    
    func ShowComponents() -> Void {
        let showProfile = isEditProfile ?? false
        
        labelNameSurname.isHidden = showProfile
        
        let showEdit = isEditProfile == false
        
        nameSurnameEdit.isHidden = showEdit
        photoButton.isHidden = showEdit
        cameraButton.isHidden = showEdit
        ageEdit.isHidden = showEdit
        genderEdit.isHidden = showEdit
        infoEdit.isHidden = showEdit
    }
    
    func LoadProfile() -> Void {
        if  let studentCurrent = student{
            photoImage.image = UIImage(named: studentCurrent.imageName)
            labelNameSurname.text = "\(studentCurrent.name) \(studentCurrent.surname)"
            ageLabel.text = "Age: \(studentCurrent.age)"
            genderLabel.text = "Gender: \(studentCurrent.gender)"
            infoLabel.text = "Info: \(studentCurrent.info)"
        }
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
