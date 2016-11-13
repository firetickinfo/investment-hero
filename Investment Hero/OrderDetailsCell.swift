//
//  OrderDetailsCell.swift
//  Investment Hero
//
//  Created by Alex Nguyen on 2016-11-12.
//  Copyright © 2016 Alex Nguyen. All rights reserved.
//

import UIKit

class OrderDetailsCell: UITableViewCell {

    @IBOutlet weak var typeLbl : UILabel!
    @IBOutlet weak var valueLbl : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setData(withType type : String, withValue value : String) {
        typeLbl.text = type
        valueLbl.text = value
    }
}
