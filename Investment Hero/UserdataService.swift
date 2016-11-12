//
//  UserdataService.swift
//  Investment Hero
//
//  Created by Alex Nguyen on 2016-11-11.
//  Copyright © 2016 Alex Nguyen. All rights reserved.
//

import Foundation

let USE_STUB_DATA = true

class UserdataService {
    static let shared = UserdataService()
    
    var orders : [Order]?
    
    func getOrders(){
        self.orders = [Order]()
        if USE_STUB_DATA {
            addOrder(withSymbol: "MSFT", withCurrPrice: 98.1, withSL: 90.1, withTP: 104, withUnrealized: 600)
            addOrder(withSymbol: "AAPL", withCurrPrice: 102.1, withSL: 80.1, withTP: 124.10, withUnrealized: 1204)
            addOrder(withSymbol: "GOOG", withCurrPrice: 230.1, withSL: 200.1, withTP: 300.10, withUnrealized: 10204)
        }
    }
    
    func addOrder(withSymbol symbol : String?, withCurrPrice currPrice : Double, withSL stopLoss : Double, withTP takeprofit: Double, withUnrealized unrealizedGain : Double) {
        let order = Order()
        order.symbol = symbol
        order.currentPrice = currPrice
        order.stopLoss = stopLoss
        order.takeProfit = takeprofit
        if self.orders != nil {
            self.orders?.append(order)
        } else {
            self.orders = [Order]()
            self.orders?.append(order)
        }
    }
    
    func calculateTotalPortfolioValue() -> Double{
        var runningTotal : Double = 0.0
        for order in orders! {
            runningTotal = runningTotal + order.unrealizedGain!
        }
        return runningTotal
    }
    
    func addOrder(withOrder order : Order) {
        if self.orders != nil {
            self.orders?.append(order)
        } else {
            self.orders = [Order]()
            self.orders?.append(order)
        }
    }
}
