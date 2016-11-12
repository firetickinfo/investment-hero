//
//  DataService.swift
//  Investment Hero
//
//  Created by Alex Nguyen on 2016-11-11.
//  Copyright © 2016 Alex Nguyen. All rights reserved.
//

import Foundation
import Firebase

class DataService {
    //Singleton
    static let shared = DataService()
    
    func signInAnonymously() {
        FIRAuth.auth()?.signInAnonymously(completion: { (user, error) in
            if let err = error { // 3
                print("IHERO : \(err.localizedDescription)")
                return
            }
            print("IHERO : User has successfully logged in")
        })
    }
}
