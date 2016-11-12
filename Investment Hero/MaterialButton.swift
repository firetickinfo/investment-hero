//
//  MaterialButton.swift
//  district
//
//  Created by Alex Nguyen on 2016-07-06.
//  Copyright © 2016 Alex Nguyen. All rights reserved.
//

import UIKit

class MaterialButton: UIButton {
    override func awakeFromNib() {
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
    }
}
