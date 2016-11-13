//
//  DataService.swift
//  Investment Hero
//
//  Created by Alex Nguyen on 2016-11-11.
//  Copyright © 2016 Alex Nguyen. All rights reserved.
//

import Foundation
import Firebase

let DB_BASE = FIRDatabase.database().reference()

class DataService {
    //Singleton
    static let shared = DataService()
    
    //References to Firebase
    private var _REF_BASE = DB_BASE
    private var _REF_ORDERS = DB_BASE.child(KEY_ORDERS)
    private var _REF_CONVERSATION = DB_BASE.child(KEY_CONVERSATION)
    
    var REF_BASE : FIRDatabaseReference {
        return _REF_BASE
    }
    var REF_ORDERS : FIRDatabaseReference {
        return _REF_ORDERS
    }
    var REF_CONVERSATION : FIRDatabaseReference {
        return _REF_CONVERSATION
    }
    
    func signInAnonymously() {
        FIRAuth.auth()?.signInAnonymously(completion: { (user, error) in
            if let err = error { // 3
                print("IHERO : \(err.localizedDescription)")
                return
            }
            print("IHERO : User has successfully logged in")
        })
    }
    func getOrdersFromFirebase(completion : ((_ orders: [Order]) -> Void)?){
        
    }
    func createNewOrder(withOrder order : Order, completion : @escaping () -> Void) {
        let newOrder = REF_ORDERS.childByAutoId()
        let data : Dictionary<String, String> = [KEY_SYMBOL : order.symbol!,
        KEY_PURCHASE_PRICE : "\(order.currentPrice!)", KEY_CURRENT_PRICE : "\(order.currentPrice!)",
            KEY_STOP_LOSS : "\(order.stopLoss!)", KEY_TAKE_PROFIT : "\(order.takeProfit!)", KEY_QUANTITY : "123", KEY_STOP_PLAN : order.stopPlan!, KEY_TAKE_PROFIT_PLAN : order.takeProfitPlan!, KEY_IMAGE : order.imgLink!]
        newOrder.updateChildValues(data){ (_,_) -> Void in
            completion()
        }
    }
    
    func recreateDefaultOrders(){
        var order = Order()
        order.symbol = "MSFT"
        order.purchasePrice = 55
        order.quantity = 123
        order.currentPrice = 50
        order.stopLoss = 46
        order.stopPlan = "Stopped out a support"
        order.takeProfit = 54
        order.takeProfitPlan = "Take profit at resistance level"
        
        self.createNewOrder(withOrder: order) { () -> Void in
        
        }
        
        order = Order()
        order.symbol = "AAPL"
        order.purchasePrice = 107.59
        order.quantity = 152
        order.currentPrice = 20
        order.stopLoss = 18.4
        order.stopPlan = "Stopped out a support"
        order.takeProfit = 21.6
        order.takeProfitPlan = "Take profit at resistance level"
        
        self.createNewOrder(withOrder: order) { () -> Void in
            
        }
        
        order = Order()
        order.symbol = "IBM"
        order.purchasePrice = 106.22
        order.quantity = 152
        order.currentPrice = 40
        order.stopLoss = 36.8
        order.stopPlan = "Stopped out a support"
        order.takeProfit = 43.2
        order.takeProfitPlan = "Take profit at resistance level"
        
        self.createNewOrder(withOrder: order) { () -> Void in
            
        }
    }
}
