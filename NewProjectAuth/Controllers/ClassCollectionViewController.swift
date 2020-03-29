//
//  ClassCollectionViewController.swift
//  NewProjectAuth
//
//  Created by Anastasiya Laptseva on 3/18/20.
//  Copyright © 2020 Anastasiya Laptseva. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class ClassCollectionViewController: UICollectionViewController {
    var students = [Student]()
    let countColumn = 2
    var selectedStudent: Student?
    var selectedColor: UIColor?
    var genderPrototypes = [GenderPrototype]()
    let segueStudentId = "studentProfile"
    override func viewDidLoad() {
        super.viewDidLoad()
        genderPrototypes.append(GenderPrototype(bacgkroundColor: UIColor(rgb: 0xFEFC9B)))
        genderPrototypes.append(GenderPrototype(bacgkroundColor: UIColor(rgb: 0xEABFEB)))
        genderPrototypes.append(GenderPrototype(bacgkroundColor: UIColor(rgb: 0x76D6FF)))
        students = LoadSave().loadStudents()
        
        for index in 0...students.count-1{
            let fullName = NetworkManager.shared.getPeople(index: index)
            //строка делится на массив подстрок, разделитель пробел
            let fullNameArr = fullName.split {$0 == " "}.map(String.init)
            //для имени берем первое значение массива
            let name = fullNameArr.count>0 ? fullNameArr[0] : ""
            //для фамилии второе
            let surname = fullNameArr.count>1 ? fullNameArr[1] : ""
            students[index].name = name
            students[index].surname = surname
        }
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return students.count/countColumn
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return countColumn
    }
    // swiftlint:disable all
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? CollectionViewCell else {
            return collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    // swiftlint:enable all
        }
        let student = students[indexPath.section*countColumn+indexPath.row]
        cell.nameSurname.text = "\(student.name) \(student.surname)"
        cell.photo.image = UIImage(named: student.imageName)
        switch student.getGender() {
        case .male:
            cell.backgroundColor = genderPrototypes[2].bacgkroundColor
        case .female:
            cell.backgroundColor = genderPrototypes[1].bacgkroundColor
        case .preferNotToSay:
            cell.backgroundColor = genderPrototypes[0].bacgkroundColor
        }
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedStudent = students[indexPath.section*countColumn+indexPath.row]
        selectedColor = collectionView.cellForItem(at: indexPath)?.backgroundColor ?? .white
        self.performSegue(withIdentifier: segueStudentId, sender: self)
    }
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == segueStudentId {
            guard let studentProfile = segue.destination as? ProfileViewController ?? nil else {
                return
            }
            studentProfile.student = selectedStudent
            //обозначем для общего окна профайл что работаем со студентами а не с профайлом
            studentProfile.isStudent = true
            studentProfile.color = selectedColor
        }
    }
}
