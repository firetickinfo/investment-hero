//
//  DefinitionsVC.swift
//  Investment Hero
//
//  Created by Alex Nguyen on 2016-11-12.
//  Copyright © 2016 Alex Nguyen. All rights reserved.
//

import UIKit

class DefinitionsVC: UIViewController {

    var tips : [String]?
    
    @IBOutlet weak var newDefLbl : UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = COLOUR_SCHEME
        generateDefs()
        let randomIndex = Int(arc4random_uniform(UInt32((tips?.count)!)))
        newDefLbl.text = tips?[randomIndex]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func generateDefs() {
        self.tips = [String]()
        var tip = "Bonds. When you invest in a bond, you are essentially loaning money to a company or government. Provided that nothing bad happens, like a bankruptcy, you cash in the bond on the maturity date and collect some interest."
        tips?.append(tip)
        tip = "Mutual fund. In layman's terms, this is a pile of money that comes from a lot of investors like you and is then invested in assets like stocks and bonds. A mutual fund may hold hundreds of stocks, with the purpose of spreading the risk. In most cases, money managers make buy and sell decisions for mutual funds, which brings us to our next definition."
        tips?.append(tip)
        tip = "Stocks. When you buy stock in a company, you're purchasing a tiny bit of ownership in the firm. Generally, the better the company performs, the more your share of stock is worth. If the company doesn't do so well, your stock may be worth less."
        tips?.append(tip)
        tip = "Price-to-earnings ratio. Remember in math class when you learned that a ratio is a relationship between two numbers? Here, you're looking at a company’s stock price in relation to its earnings."
        tips?.append(tip)
        tip = "When getting started, it is important that you pick the right full service or discount brokerage. If you use a broker, make sure he or she has a good track record."
        tips?.append(tip)
        
    }
}
