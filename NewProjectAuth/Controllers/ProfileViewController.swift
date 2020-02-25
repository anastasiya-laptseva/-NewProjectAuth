//
//  StudentProfileViewController.swift
//  NewProjectAuth
//
//  Created by Anastasiya Laptseva on 2/20/20.
//  Copyright © 2020 Anastasiya Laptseva. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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
    var isStudent: Bool?
    var imagePicker = UIImagePickerController()
    var profileManager = ProfileManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if isStudent ?? false{
            profileStudent()
            isEditing = false
        }
        else{
            profileMain()
        }
        ShowComponents()
    }
    
    func profileStudent() -> Void {
        if let colorView = color{
            profileView.backgroundColor = colorView
        }
        
        setProfile()
    }
    
    func profileMain() -> Void{
        if(isEditing){
            
        }
        else{
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveClick))
        }
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
            student?.imageName = info[.imageURL] as! String
            dismiss(animated: true, completion: nil)
        }
    }
    
    func StudentComponents() -> Void {
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
    
    func ProfileComponents(<#parameters#>) -> <#return type#> {
        <#function body#>
    }
    
    func setProfile() -> Void {
        if  let studentCurrent = student{
            photoImage.image = UIImage(named: studentCurrent.imageName)
            labelNameSurname.text = "\(studentCurrent.name) \(studentCurrent.surname)"
            ageLabel.text = "Age: \(studentCurrent.age)"
            genderLabel.text = "Gender: \(studentCurrent.gender)"
            infoLabel.text = "Info: \(studentCurrent.info)"
        }
    }
    
    @objc func saveClick() -> Void {
        if let currentStudent = student{
            self.profileManager.saveProfile(student: currentStudent)
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
