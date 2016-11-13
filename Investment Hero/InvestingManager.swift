//
//  InvestingManager.swift
//  Investment Hero
//
//  Created by Alex Nguyen on 2016-11-12.
//  Copyright © 2016 Alex Nguyen. All rights reserved.
//

import Foundation
import Firebase

class InvestingManager {
    static let shared = InvestingManager()
    
    func observeNewMessages() {
        DataService.shared.REF_CONVERSATION.observe(FIRDataEventType.childAdded, with: { (snapshot) -> Void in
            if let child = snapshot.value as? Dictionary<String, AnyObject>{
                if let type = child["type"] as? String {
                    print(type)
                }
            }
        })
    }
}
