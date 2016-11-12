//
//  ConversationVCViewController.swift
//  Investment Hero
//
//  Created by Alex Nguyen on 2016-11-11.
//  Copyright © 2016 Alex Nguyen. All rights reserved.
//

import UIKit
import JSQMessagesViewController
import Firebase

class ConversationVC: UIViewController {

    private var chatVC : ChatVC?
    
    //MARK - Initializers
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == CHAT_SEGUE {
            chatVC = segue.destination as? ChatVC
            chatVC?.senderId = FIRAuth.auth()?.currentUser?.uid
            chatVC?.senderDisplayName = "YHack 2016"
        }
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
