//
//  GestureDemonstrationViewController.swift
//  NewProjectAuth
//
//  Created by Anastasiya Laptseva on 4/2/20.
//  Copyright © 2020 Anastasiya Laptseva. All rights reserved.
//

import UIKit

class GestureDemonstrationViewController: UIViewController {
    
    @IBOutlet weak var imageSeasons: UIImageView!
    var currentNumber: Int = 0
    let pictures: [String] = ["autumn","winter","spring","summer"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let gesturePan = UIPanGestureRecognizer(target: self, action: #selector(drag))
        self.view.addGestureRecognizer(gesturePan)
        let gestureTap = UITapGestureRecognizer(target: self, action: #selector(tap))
        self.view.addGestureRecognizer(gestureTap)
        let gesturePinch = UIPinchGestureRecognizer(target: self, action: #selector(pinch))
        self.view.addGestureRecognizer(gesturePinch)
        let gestureRotate = UIRotationGestureRecognizer(target: self, action: #selector(rotate))
        self.imageSeasons.addGestureRecognizer(gestureRotate)
        
        //        let gestureSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipe))
        //        self.view.addGestureRecognizer(gestureSwipe)
        
        //        view.isUserInteractionEnabled = true
        
        
        // У меня не получилось сделать одновременно и Pan и Swipe. Oни конфликтуют
        
        
        // Do any additional setup after loading the view.
    }
    //    @objc func swipe(sender: UISwipeGestureRecognizer)  {
    //        if sender.state == .ended {
    //            switch sender.direction {
    //            case .left:
    //                imageSeasons.center = CGPoint(x: imageSeasons.center.x - 10, y: imageSeasons.center.y)
    //                break
    //            case .right:
    //                imageSeasons.center = CGPoint(x: imageSeasons.center.x + 10, y: imageSeasons.center.y)
    //            break
    //            case .up:
    //                imageSeasons.center = CGPoint(x: imageSeasons.center.x, y: imageSeasons.center.y + 10)
    //            break
    //            case .down:
    //                imageSeasons.center = CGPoint(x: imageSeasons.center.x, y: imageSeasons.center.y - 10)
    //            break
    //            default:
    //                break
    //            }
    //        }
    //    }
    @objc func rotate(sender: UIRotationGestureRecognizer) {
        guard sender.view != nil else { return }
        
        if sender.state == .began || sender.state == .changed {
            imageSeasons.transform = imageSeasons.transform.rotated(by: sender.rotation)
            sender.rotation = 0
        }
    }
    
    @objc func pinch(sender: UIPinchGestureRecognizer) {
        guard sender.view != nil else { return }
        
        if sender.state == .began || sender.state == .changed {
            imageSeasons.transform = imageSeasons.transform.scaledBy(x: sender.scale, y: sender.scale)
            sender.scale = 1.0
        }
    }
    
    @objc func tap(sender: UITapGestureRecognizer) {
        switchCapture()
    }
    
    @objc func drag(sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .changed:
            let translition = sender.translation(in: imageSeasons)
            imageSeasons.center = CGPoint(x: imageSeasons.center.x + translition.x, y: imageSeasons.center.y + translition.y)
            sender.setTranslation(CGPoint.zero, in: imageSeasons)
            break
        default:
            break
        }
    }
    
    func switchCapture()  {
        let name = pictures[currentNumber]
        currentNumber += 1
        imageSeasons.image = UIImage(named: name)
        if currentNumber > 3 {
            currentNumber = 0
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
