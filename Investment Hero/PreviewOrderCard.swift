//
//  PreviewOrderCard.swift
//  Investment Hero
//
//  Created by Alex Nguyen on 2016-11-12.
//  Copyright © 2016 Alex Nguyen. All rights reserved.
//

import UIKit

protocol PreviewOrderCardDelegate {
    func didCreateOrder()
}
class PreviewOrderCard: UIView {

    @IBInspectable var cornerRadius: CGFloat = 3.0 {
        didSet {
            setupView()
        }
    }
    
    @IBOutlet weak var qtyTxt : MaterialTextField!
    @IBOutlet weak var slTxt : MaterialTextField!
    @IBOutlet weak var tpTxt : MaterialTextField!
    @IBOutlet weak var slPlanTxt : MaterialTextField!
    @IBOutlet weak var tpPlanTxt : MaterialTextField!
    
    var delegate : PreviewOrderCardDelegate?
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
        
    }
    override func awakeFromNib() {
        setupView()
    }
    
    func createOrder(withSymbol symbol : Symbol?){
        
        let newOrder = Order()
        newOrder.currentPrice = symbol?.close
        newOrder.symbol = symbol?.symbolName
        newOrder.stopLoss = Double(slTxt.text!)
        newOrder.takeProfit = Double(tpTxt.text!)
        newOrder.stopPlan = slPlanTxt.text
        newOrder.takeProfitPlan = tpPlanTxt.text
        
        DataService.shared.createNewOrder(withOrder: newOrder) { () -> Void in
            self.delegate?.didCreateOrder()
        }
    }
    func setupView() {
        self.layer.cornerRadius = cornerRadius
        self.layer.shadowOpacity = 0.8
        self.layer.shadowRadius = 5.0
        self.layer.shadowOffset = CGSize(width : 0.0, height : 2.0)
        self.layer.shadowColor = UIColor(red: 157.0/255.0, green: 157.0/255.0, blue: 157.0/255.0, alpha: 1.0).cgColor
        self.setNeedsLayout()
    }

}
