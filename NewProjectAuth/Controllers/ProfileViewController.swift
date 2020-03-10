//
//  StudentProfileViewController.swift
//  NewProjectAuth
//
//  Created by Anastasiya Laptseva on 2/20/20.
//  Copyright © 2020 Anastasiya Laptseva. All rights reserved.
//

import UIKit

//общее окно для студентов и самого профиля
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
    
    //хранится текущий студент или профиль
    var student: Student?
    //для студентов передается цвет
    var color: UIColor?
    //переменная для определения редактирование или отображения профиля
    var isEditProfile: Bool = false
    //студент или профиль
    var isStudent: Bool = false
    //с помощью этого объекта можно получать картинки из галереи или камеры
    var imagePicker = UIImagePickerController()
    //менеджер для работы с профилем или студентом
    var genderParcer = GenderParcer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //если открывается профиль а не студент
        if isStudent == false{
            //если профиль уже создавался
            if ProfileManager.shared.isProfile(){
                //загружаем профиль
                student = ProfileManager.shared.loadProfile()
            }
            //если профиль не создавался
            else{
                //включаем редактирование
                isEditing = true;
            }
        }
        startProfile()
    }
    
    //этот метод выбирает как настроить и загрузить данные в profileviewcontroller
    func startProfile() -> Void {
        if isStudent {
            profileStudent()
        }
        else{
            profileMain()
        }
    }
    
    func profileStudent() -> Void {
        //устанавливает цвет бэкграунда
        if let colorView = color{
            profileView.backgroundColor = colorView
        }
        
        setProfile()
        showComponents()
    }
    
    
    func profileMain() -> Void{
        //если он включен на редактирование/создание
        if(isEditing){
            //необходимо сбросить значения лейблов которые не скрываются
            ageLabel.text = "Age:"
            genderLabel.text = "Gender:"
            infoLabel.text = "Info:"
            // добавляев навигационный бар кнопку сохранения
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveClick))
        }
        else{
            //если профайл не редактируется и создан, то нужно его сначала загрузить
            setProfile()
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editClick))
        }
        
        //в зависимости от того редактирование/создание или нет включаются и выключаются нужные компоненты
        showComponents()
    }
    
    //не используется
    @IBAction func changeGender(_ sender: Any) {
        print(genderEdit.selectedSegmentIndex)
    }
    
    //клик по кнопке галерея для загрузки фото
    @IBAction func galleryClick(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            //указываем что у нас реализованы протоколы получения фото
            imagePicker.delegate = self
            //указываем тип что мы хотим иметь: альбом или камеру
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = false
            //открываем альбом
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @IBAction func photoClick(_ sender: Any) {
        if(UIImagePickerController .isSourceTypeAvailable(.camera)){
            imagePicker.sourceType = .camera
            //открываем камеру
            self.present(imagePicker, animated: true, completion: nil)
        }
        else{
            print("Camera is not Available")
        }
    }
    
    //чтобы закрыть окно галереи
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        //выйти из окна
        dismiss(animated: true, completion: nil)
    }

    //делегат дает нам фото из галереи которое мы кликнули
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        //здесь из объекта info который нам возвращает imagePicker мы можем получить всю информацию о фото
        //в данном случае мы забираем по ключу оригинал картинки
        if let image = info[.originalImage] as? UIImage {
            //в наше image photo заносим полученную картиинку
            photoImage.image = image
            //получаем путь картинки
            let url = "\(info[.imageURL] ?? "")"
            //получаем массив объектов по разделителю /
            let fullNameArr = url.split{$0 == "/"}.map(String.init)
            student?.imageName = fullNameArr[fullNameArr.count-1]
            dismiss(animated: true, completion: nil)
        }
    }
    
    //включаются выключаются компоненты в зависимости о того загружен профиль или студент а также редактируется он или нет
    func showComponents() -> Void {
        
        let hideEdit = isStudent || isEditing == false
        
        //Edit components
        nameSurnameEdit.isHidden = hideEdit
        cameraButtonEdit.isHidden = hideEdit
        photoButtonEdit.isHidden = hideEdit
        ageEdit.isHidden = hideEdit
        genderEdit.isHidden = hideEdit
        infoEdit.isHidden = hideEdit
        
        
        let hideMain = isEditing;
        //Main components
        labelNameSurname.isHidden = hideMain
    }
    
    //расставляет значения из student объекта по компонентам обычным
    func setProfile() -> Void {
        if  let studentCurrent = student{

            if isStudent{
                if let image = UIImage(named: studentCurrent.imageName){
                    photoImage.image = image
                }
            }
            else{
                let nsDocumentDirectory = FileManager.SearchPathDirectory.documentDirectory
                let nsUserDomainMask    = FileManager.SearchPathDomainMask.userDomainMask
                let paths               = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true)
                if let dirPath          = paths.first
                {
                    let imageURL = URL(fileURLWithPath: dirPath).appendingPathComponent(studentCurrent.imageName)
                   let image    = UIImage(contentsOfFile: imageURL.path)
                    photoImage.image = image
                }
            }

            labelNameSurname.text = "\(studentCurrent.name) \(studentCurrent.surname)"
            ageLabel.text = "Age: \(studentCurrent.age)"
            genderLabel.text = "Gender: \(studentCurrent.gender)"
            infoLabel.text = "Info: \(studentCurrent.info)"
        }
    }
    
    //расставляет значения из student объекта по компонентам для редактирования
    func setEditProfile() -> Void {
        if  let studentCurrent = student{
                
            let nsDocumentDirectory = FileManager.SearchPathDirectory.documentDirectory
            let nsUserDomainMask    = FileManager.SearchPathDomainMask.userDomainMask
            let paths               = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true)
            if let dirPath          = paths.first
            {
                let imageURL = URL(fileURLWithPath: dirPath).appendingPathComponent(studentCurrent.imageName)
               let image    = UIImage(contentsOfFile: imageURL.path)
                photoImage.image = image
            }
            
            nameSurnameEdit.text = "\(studentCurrent.name) \(studentCurrent.surname)"
            ageEdit.text = "\(studentCurrent.age)"
            genderEdit.selectedSegmentIndex = genderParcer.getIntGender(value: studentCurrent.getGender())
            infoEdit.text = "\(studentCurrent.info)"
        }
    }
    
    
    //собирает все данные из edit компонентов и формирует student объект, отправляет в сохранения
    @objc func saveClick() -> Void {
        //из namesurnameedit выделяются имя и фамилия сплитом по пробелу
        let fullName = nameSurnameEdit.text
        let fullNameArr = fullName?.split{$0 == " "}.map(String.init)
        var firstName = ""
        var lastName = ""
        if let array = fullNameArr{
            firstName = array.count>0 ? array[0] : ""
            lastName = array.count>1 ? array[1] : ""
        }
        let genderString = genderParcer.getGenderInt(value: genderEdit.selectedSegmentIndex).rawValue
        
        //создается объект студента из edit компонентов
        let currentStudent = Student(imageName: student?.imageName ?? "", name: firstName, surname: lastName , age: ageEdit.text ?? "", info: infoEdit.text ?? "", gender: genderString)
        //отправляется в сохранение объект созданного/редактируемого студента
        ProfileManager.shared.saveProfile(student: currentStudent)
        //текущему профилю кешируется то что мы создали редактированием
        student = currentStudent
        //отключаем редактирование
        isEditing = false
        //перезагружаем
        startProfile()
    }
    
    //включаем редактирование
    @objc func editClick() -> Void {
        isEditing = true
        //подгружаем в edit компоненты профиль из student
        setEditProfile()
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
