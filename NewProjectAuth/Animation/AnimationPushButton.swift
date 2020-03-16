//
//  AnimationPushButton.swift
//  NewProjectAuth
//
//  Created by Anastasiya Laptseva on 3/16/20.
//  Copyright © 2020 Anastasiya Laptseva. All rights reserved.
//

import UIKit

class AnimationPushButton {
    var state = 0
    func pushPress(view: UIView) {
        state+=1
        switch state {
        case 1:
            push1(view: view)
        case 2:
            push2(view: view)
        case 3:
            push3(view: view)
        state = 0
        default:
            push1(view: view)
        }
    }
    private func push1(view: UIView) {
        print("push1")
        //view.isUserInteractionEnabled = false
        let constraintWidth = view.widthAnchor.constraint(equalToConstant: view.bounds.height)
        constraintWidth.isActive = true
        UIView.animate(withDuration: 1) {
            view.layoutIfNeeded()
        }
    }
    private func push2(view: UIView) {
        print("push2")
        //view.layer.masksToBounds = true
        UIView.animate(withDuration: 1) {
            view.layer.cornerRadius = view.bounds.height/2
            view.backgroundColor = .red
        }
    }
    private func push3(view: UIView) {
        print("push3")
        UIView.animate(withDuration: 1) {
            view.transform = CGAffineTransform(translationX: 0, y: -500)
        }
    }
}
