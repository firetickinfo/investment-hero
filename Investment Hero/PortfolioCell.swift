//
//  PortfolioCell.swift
//  Investment Hero
//
//  Created by Alex Nguyen on 2016-11-11.
//  Copyright © 2016 Alex Nguyen. All rights reserved.
//

import UIKit

class PortfolioCell: UITableViewCell {

    @IBOutlet weak var symbolLbl : UILabel!
    @IBOutlet weak var currentPriceLbl : UILabel!
    @IBOutlet weak var stopLossLbl : UILabel!
    @IBOutlet weak var takeProfitLbl : UILabel!
    @IBOutlet weak var unrealizedGainLbl : UILabel!
    @IBOutlet weak var tickerLogo : UIImageView!
    
    private var order : Order!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(withOrder order : Order){
        if let symbol = order.symbol {
            symbolLbl.text = symbol
            tickerLogo.image = UIImage(named: "\(symbol.uppercased()).jpg")
        }
        if let currPrice = order.currentPrice {
            currentPriceLbl.text = currPrice.asLocaleCurrency
        }
        if let stoploss = order.stopLoss {
            stopLossLbl.text = "S/L : \(stoploss.asLocaleCurrency)"
        }
        if let takeProfit = order.takeProfit {
            takeProfitLbl.text = "T/P : \(takeProfit.asLocaleCurrency)"
        }
        if let unrealizedGain = order.unrealizedGain {
            if unrealizedGain > 0 {
                unrealizedGainLbl.text = "+ \(unrealizedGain.asLocaleCurrency)"
                unrealizedGainLbl.textColor = COLOUR_SCHEME
            } else {
                unrealizedGainLbl.text = "\(unrealizedGain.asLocaleCurrency)"
                unrealizedGainLbl.textColor = UIColor.red
            }
        }
        
    }

}
