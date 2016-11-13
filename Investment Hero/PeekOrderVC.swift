//
//  PeekOrderVC.swift
//  Investment Hero
//
//  Created by Alex Nguyen on 2016-11-12.
//  Copyright © 2016 Alex Nguyen. All rights reserved.
//

import UIKit

class PeekOrderVC: UIViewController {

    @IBOutlet weak var symbol : UILabel!
    @IBOutlet weak var tickerLogo : UIImageView!
    @IBOutlet weak var loadingSpinner : UIActivityIndicatorView!
    @IBOutlet weak var loadingDataLbl : UILabel!
    @IBOutlet weak var orderDetailsTableView : UITableView! {
        didSet {
            orderDetailsTableView.delegate = self
            orderDetailsTableView.dataSource = self
        }
    }
    var order : Order!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadingSpinner.isHidden = false
        loadingSpinner.startAnimating()
        
        if let symbol = order.symbol {
            self.symbol.text = symbol
            self.tickerLogo.image = UIImage(named: "\(symbol).jpg")
            WebService.shared.searchForSymbol(withSymbol: symbol, completion: { (found, symbolResponse) in
                self.loadingSpinner.stopAnimating()
                self.loadingSpinner.isHidden = true
                self.loadingDataLbl.isHidden = true
                self.showStockDetails(withSymbol: symbolResponse!)
            })
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createCardFromNib() -> SymbolCard? {
        return Bundle.main.loadNibNamed("SymbolCard", owner: self, options: nil)?[0] as? SymbolCard
    }
    
    func showStockDetails(withSymbol symbol : Symbol){
        if let symbolCard = self.createCardFromNib() {
            symbolCard.setupCard(withSymbol: symbol)
            symbolCard.center = AnimationEngine.offScreenRightPosition
            self.view.addSubview(symbolCard)
            AnimationEngine.animateToPosition(view : symbolCard, position: CGPoint(x: UIScreen.main.bounds.midX, y: 200), completion: { (_, _) in
            })
        }
    }
    func setup(withOrder order : Order) {
        self.order = order
    }
}

extension PeekOrderVC : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: ORDER_DETAILS_CELL, for: indexPath) as? OrderDetailsCell {
            if (indexPath.row == 0) {
                cell.setData(withType: "Current Price", withValue: (order.currentPrice!.asLocaleCurrency))
            } else if (indexPath.row == 1) {
                cell.setData(withType: "Purchase Price", withValue: order.purchasePrice!.asLocaleCurrency)
            }
            else if (indexPath.row == 2) {
                cell.setData(withType: "Quantity", withValue: String(describing: order.quantity!))
            }
            else if (indexPath.row == 3) {
                cell.setData(withType: "Stop-Loss", withValue: order.stopLoss!.asLocaleCurrency)
            }
            else if (indexPath.row == 4) {
                cell.setData(withType: "Stop-Loss Plan", withValue: order.stopPlan!)
            }
            else if (indexPath.row == 5) {
                cell.setData(withType: "Take-Profit", withValue: order.takeProfit!.asLocaleCurrency)
            }
            if (indexPath.row == 6) {
                cell.setData(withType: "Take-Profit Plan", withValue: order.takeProfitPlan!)
            }
            return cell
        }
        return UITableViewCell()
    }
}
