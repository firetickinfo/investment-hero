//
//  Order.swift
//  Investment Hero
//
//  Created by Alex Nguyen on 2016-11-11.
//  Copyright © 2016 Alex Nguyen. All rights reserved.
//

import Foundation

class Order {
    var symbol : String?
    var currentPrice : Double?
    var stopLoss : Double?
    var takeProfit : Double?
    var unrealizedGain : Double? {
        let bookValue = purchasePrice! * quantity!
        let marketValue = currentPrice! * quantity!
        return marketValue - bookValue
    }
    var stopPlan : String?
    var takeProfitPlan : String?
    var purchasePrice : Double?
    var quantity : Double?
    var imgLink : String? {
        return "http://investment-hero.herokuapp.com/img/\(self.symbol!.uppercased()).jpg"
    }
}
