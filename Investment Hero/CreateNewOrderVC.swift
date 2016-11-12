//
//  CreateNewOrderVC.swift
//  Investment Hero
//
//  Created by Alex Nguyen on 2016-11-11.
//  Copyright © 2016 Alex Nguyen. All rights reserved.
//

import UIKit

protocol NewOrderDelegate {
    func dismissNewOrderScreen()
}

class CreateNewOrderVC: UIViewController {

    @IBOutlet weak var popUpView: MaterialView!
    
    var delegate : NewOrderDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        self.popUpView.layer.cornerRadius = 0
        self.popUpView.layer.shadowOpacity = 0.8
        self.popUpView.layer.shadowOffset = CGSize(width : 0.0, height : 0.0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override var prefersStatusBarHidden : Bool {
        return true
    }
    func removeAnimate()
    {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0;
        }, completion:{(finished : Bool)  in
            if (finished)
            {
                self.view.removeFromSuperview()
                self.dismiss(animated: false, completion: nil)
            }
        });
    }
    @IBAction func cancelBtnPressed(_ sender: AnyObject) {
        delegate?.dismissNewOrderScreen()
        self.removeAnimate()
    }
}
