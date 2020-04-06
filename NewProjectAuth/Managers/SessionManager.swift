//
//  SessionManager.swift
//  NewProjectAuth
//
//  Created by Anastasiya Laptseva on 4/6/20.
//  Copyright © 2020 Anastasiya Laptseva. All rights reserved.
//

import Foundation

class SessionManager {
    static let shared = SessionManager()
    private let keySession = "session_number"
    private var session = 0
    
    private init() {
    }
    
    func getSession() -> Int {
        return session
    }
    
    func startSession() {
        let userDefault = UserDefaults.standard
        if let s: AnyObject = userDefault.object(forKey: keySession) as AnyObject? {
            session = s as! Int + 1
        }
        else{
            session = 1
        }
        userDefault.set(session, forKey: keySession)
    }
}
