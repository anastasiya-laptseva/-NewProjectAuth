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
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? CollectionViewCell else {
            return collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
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

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
