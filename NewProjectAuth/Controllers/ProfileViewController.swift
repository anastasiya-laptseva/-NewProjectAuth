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
    @IBOutlet weak var cameraButtonEdit: UIButton!
    @IBOutlet weak var photoButtonEdit: UIButton!
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
    var storage = StudentStorage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isEditing = student == nil
        startProfile()
    }
    
    func startProfile() -> Void {
        if isStudent ?? false{
            profileStudent()
        }
        else{
            profileMain()
        }
    }
    
    func profileStudent() -> Void {
        isEditing = false
        
        if let colorView = color{
            profileView.backgroundColor = colorView
        }
        
        setProfile()
        showComponents()
    }
    
    func profileMain() -> Void{
        isStudent = false
        
        student = profileManager.loadProfile()
        setProfile()
        
        if(isEditing){
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveClick))
        }
        else{
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editClick))
        }
        
        showComponents()
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
    
    func showComponents() -> Void {
        
        let hide = isStudent! || isEditing == false
        
        //Edit components
        nameSurnameEdit.isHidden = hide
        cameraButtonEdit.isHidden = hide
        photoButtonEdit.isHidden = hide
        ageEdit.isHidden = hide
        genderEdit.isHidden = hide
        infoEdit.isHidden = hide
        
        //Main components
        labelNameSurname.isHidden = hide == false
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
        let fullName = nameSurnameEdit.text
        let fullNameArr = fullName?.split{$0 == " "}.map(String.init)
        let firstName: String = fullNameArr?[0] ?? ""
        let lastName: String? = fullNameArr?.count ?? 0 > 1 ? fullNameArr?[1] ?? "" : nil
        
        let genderString = storage.getGenderInt(value: genderEdit.selectedSegmentIndex).rawValue
        
        let currentStudent = Student(imageName: "", name: firstName, surname: lastName ?? "", age: ageEdit.text ?? "", info: infoEdit.text ?? "", gender: genderString)
        self.profileManager.saveProfile(student: currentStudent)
        isEditing = false
        startProfile()
    }
    
    @objc func editClick() -> Void {
        isEditing = true
        startProfile()
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
