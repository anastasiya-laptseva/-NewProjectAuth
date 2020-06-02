//
//  StudentProfileViewController.swift
//  NewProjectAuth
//
//  Created by Anastasiya Laptseva on 2/20/20.
//  Copyright © 2020 Anastasiya Laptseva. All rights reserved.
//

import UIKit

//общее окно для студентов и самого профиля
class ProfileViewController: UIViewController, ImageProtocol {
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var containerProfile: UIView!
    // MARK: PreviewComponents
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    // MARK: EditComponents
    @IBOutlet weak var ageEdit: UITextField!
    @IBOutlet weak var genderEdit: UISegmentedControl!
    @IBOutlet weak var infoEdit: UITextField!
    // MARK: Variables
    //хранится текущий студент или профиль
    var student: Student?
    //для студентов передается цвет
    var color: UIColor?
    //переменная для определения редактирование или отображения профиля
    var isEditProfile: Bool = false
    //студент или профиль
    var isStudent: Bool = false
    //менеджер для работы с профилем или студентом
    var genderParcer = GenderParcer()
    var profilePerson = ProfilePersonViewController()
    override func viewDidLoad() {
        super.viewDidLoad()
        addProfilePerson(version: WelcomeViewController.style)
        profilePerson.delegate = self
        //если открывается профиль а не студент
        if isStudent == false {
            //если профиль уже создавался
            if ProfileManager.shared.isProfile() {
                //загружаем профиль
                student = ProfileManager.shared.loadProfile()
            }
            //если профиль не создавался
            else {
                //включаем редактирование
                isEditing = true
            }
        }
        startProfile()
    }
    func addProfilePerson(version: Int) {
        let name = "profilePerson\(version)"
        // swiftlint:disable all
        profilePerson = storyboard?.instantiateViewController(withIdentifier: name) as? ProfilePersonViewController ?? ProfilePersonViewController()
        // swiftlint:enable all
        addChild(profilePerson)
        //Or, you could add auto layout constraint instead of relying on AutoResizing contraints
        profilePerson.view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        profilePerson.view.frame = containerProfile.bounds
        containerProfile.addSubview(profilePerson.view)
        profilePerson.didMove(toParent: self)
    }
    //этот метод выбирает как настроить и загрузить данные в profileviewcontroller
    func startProfile() {
        if isStudent {
            profileStudent()
        } else {
            profileMain()
        }
    }
    func profileStudent() {
        //устанавливает цвет бэкграунда
        if let colorView = color {
            setBackColorView(color: colorView)
        }
        setProfile()
        showComponents()
    }
    func setBackColorView(color: UIColor) {
        profileView.backgroundColor = color
        profilePerson.view.backgroundColor = color
    }
    func profileMain() {
        //если он включен на редактирование/создание
        if isEditing {
            //необходимо сбросить значения лейблов которые не скрываются
            ageLabel.text = "Age:"
            genderLabel.text = "Gender:"
            infoLabel.text = "Info:"
            // добавляев навигационный бар кнопку сохранения
            // swiftlint:disable all
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveClick))
            // swiftlint:enable all
        } else {
            //если профайл не редактируется и создан, то нужно его сначала загрузить
            setProfile()
            // swiftlint:disable all
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editClick))
            // swiftlint:enable all
        }
        //в зависимости от того редактирование/создание или нет включаются и выключаются нужные компоненты
        showComponents()
    }
    //не используется
    @IBAction func changeGender(_ sender: Any) {
        print(genderEdit.selectedSegmentIndex)
    }
    //чтобы закрыть окно галереи
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        //выйти из окна
        dismiss(animated: true, completion: nil)
    }
//    включаются выключаются компоненты
//    в зависимости о того загружен профиль или студент а также редактируется он или нет
    func showComponents() {
        let hideEdit = isStudent || isEditing == false
        //Edit components
        profilePerson.nameSurnameEdit.isHidden = hideEdit
        profilePerson.cameraButtonEdit.isHidden = hideEdit
        profilePerson.photoButtonEdit.isHidden = hideEdit
        ageEdit.isHidden = hideEdit
        genderEdit.isHidden = hideEdit
        infoEdit.isHidden = hideEdit
        let hideMain = isEditing
        //Main components
        profilePerson.labelNameSurname.isHidden = hideMain
    }
    //расставляет значения из student объекта по компонентам обычным
    func setProfile() {
        if  let studentCurrent = student {
            if isStudent {
                if let image = UIImage(named: studentCurrent.imageName) {
                    profilePerson.photoImage.image = image
                }
            } else {
                let nsDocumentDirectory = FileManager.SearchPathDirectory.documentDirectory
                let nsUserDomainMask = FileManager.SearchPathDomainMask.userDomainMask
                let paths = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true)
                if let dirPath = paths.first {
                    let imageURL = URL(fileURLWithPath: dirPath).appendingPathComponent(studentCurrent.imageName)
                   let image    = UIImage(contentsOfFile: imageURL.path)
                    profilePerson.photoImage.image = image
                }
            }

            profilePerson.labelNameSurname.text = "\(studentCurrent.name) \(studentCurrent.surname)"
            ageLabel.text = "Age: \(studentCurrent.age)"
            genderLabel.text = "Gender: \(studentCurrent.gender)"
            infoLabel.text = "Info: \(studentCurrent.info)"
        }
    }
    //расставляет значения из student объекта по компонентам для редактирования
    func setEditProfile() {
        if  let studentCurrent = student {
            let nsDocumentDirectory = FileManager.SearchPathDirectory.documentDirectory
            let nsUserDomainMask = FileManager.SearchPathDomainMask.userDomainMask
            let paths = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true)
            if let dirPath = paths.first {
                let imageURL = URL(fileURLWithPath: dirPath).appendingPathComponent(studentCurrent.imageName)
               let image    = UIImage(contentsOfFile: imageURL.path)
                profilePerson.photoImage.image = image
            }
            profilePerson.nameSurnameEdit.text = "\(studentCurrent.name) \(studentCurrent.surname)"
            ageEdit.text = "\(studentCurrent.age)"
            genderEdit.selectedSegmentIndex = genderParcer.getIntGender(value: studentCurrent.getGender())
            infoEdit.text = "\(studentCurrent.info)"
        }
    }
    //собирает все данные из edit компонентов и формирует student объект, отправляет в сохранения
    @objc func saveClick() {
        //из namesurnameedit выделяются имя и фамилия сплитом по пробелу
        let fullName = profilePerson.nameSurnameEdit.text
        let fullNameArr = fullName?.split {$0 == " "}.map(String.init)
        var firstName = ""
        var lastName = ""
        if let array = fullNameArr {
            firstName = array.count>0 ? array[0] : ""
            lastName = array.count>1 ? array[1] : ""
        }
        let genderString = genderParcer.getGenderInt(value: genderEdit.selectedSegmentIndex).rawValue
        //создается объект студента из edit компонентов
        // swiftlint:disable all
        let currentStudent = Student(imageName: student?.imageName ?? "", name: firstName, surname: lastName, age: ageEdit.text ?? "", info: infoEdit.text ?? "", gender: genderString)
        // swiftlint:enable all
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
    @objc func editClick() {
        isEditing = true
        //подгружаем в edit компоненты профиль из student
        setEditProfile()
        startProfile()
    }
    func infoSend(info: [UIImagePickerController.InfoKey: Any]) {
        //в данном случае мы забираем по ключу оригинал картинки
        if let image = info[.originalImage] as? UIImage {
            //в наше image photo заносим полученную картиинку
            profilePerson.photoImage.image = image
            //получаем путь картинки
            let url = "\(info[.imageURL] ?? "")"
            //получаем массив объектов по разделителю /
            let fullNameArr = url.split {$0 == "/"}.map(String.init)
            student?.imageName = fullNameArr[fullNameArr.count-1]
            dismiss(animated: true, completion: nil)
        }
    }
}
