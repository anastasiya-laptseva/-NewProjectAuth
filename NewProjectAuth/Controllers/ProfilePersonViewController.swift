//
//  ProfilePersonViewController.swift
//  NewProjectAuth
//
//  Created by Anastasiya Laptseva on 3/12/20.
//  Copyright © 2020 Anastasiya Laptseva. All rights reserved.
//

import UIKit

protocol ImageProtocol: AnyObject {
    func infoSend(info: [UIImagePickerController.InfoKey: Any])
}

class ProfilePersonViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // MARK: PreviewComponents
    @IBOutlet weak var labelNameSurname: UILabel!
    @IBOutlet weak var photoImage: UIImageView!
    // MARK: EditComponents
    @IBOutlet weak var nameSurnameEdit: UITextField!
    @IBOutlet weak var cameraButtonEdit: UIButton!
    @IBOutlet weak var photoButtonEdit: UIButton!
    // MARK: Delegates
    weak var delegate: ImageProtocol?
    //с помощью этого объекта можно получать картинки из галереи или камеры
    var imagePicker = UIImagePickerController()
    override func viewDidLoad() {
        super.viewDidLoad()
        animatePhoto()
    }
    //клик по кнопке галерея для загрузки фото
    @IBAction func galleryClick(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
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
        if UIImagePickerController .isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
            //открываем камеру
            self.present(imagePicker, animated: true, completion: nil)
        } else {
            print("Camera is not Available")
        }
    }
    //делегат дает нам фото из галереи которое мы кликнули
    // swiftlint:disable all
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
    // swiftlint:enable all
        //здесь из объекта info который нам возвращает imagePicker мы можем получить всю информацию о фото
        delegate?.infoSend(info: info)
    }
    func animatePhoto() {
        if WelcomeViewController.style == 1 {
            //photoImage
            UIView.animate(withDuration: 1) {
                self.photoImage.layer.cornerRadius = 100
            }
        }
    }
}
