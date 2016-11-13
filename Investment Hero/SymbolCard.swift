//
//  SymbolCard.swift
//  Investment Hero
//
//  Created by Alex Nguyen on 2016-11-12.
//  Copyright © 2016 Alex Nguyen. All rights reserved.
//

import UIKit

class SymbolCard: UIView {

    @IBInspectable var cornerRadius: CGFloat = 3.0 {
        didSet {
            setupView()
        }
    }
    
    @IBOutlet weak var symbolLbl : UILabel!
    @IBOutlet weak var highLbl : UILabel!
    @IBOutlet weak var lowLbl : UILabel!
    @IBOutlet weak var closeLbl : UILabel!
    @IBOutlet weak var volumeLbl : UILabel!
    @IBOutlet weak var cannotFindSymbol : UILabel!
    @IBOutlet weak var tickerLogo : UIImageView!
    
    var symbol : Symbol?
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
        
    }
    override func awakeFromNib() {
        setupView()
    }
    
    func setupView() {
        self.layer.cornerRadius = cornerRadius
        self.layer.shadowOpacity = 0.8
        self.layer.shadowRadius = 5.0
        self.layer.shadowOffset = CGSize(width : 0.0, height : 2.0)
        self.layer.shadowColor = UIColor(red: 157.0/255.0, green: 157.0/255.0, blue: 157.0/255.0, alpha: 1.0).cgColor
        self.setNeedsLayout()
    }

    func displayNoSymbolFound(){
        symbolLbl.isHidden = true
        highLbl.isHidden = true
        lowLbl.isHidden = true
        closeLbl.isHidden = true
        volumeLbl.isHidden = true
        cannotFindSymbol.isHidden = false
    }
    func setupCard(withSymbol symbol : Symbol?){
        if symbol == nil {
            displayNoSymbolFound()
        } else {
            if let symbol = symbol {
                symbolLbl.text = symbol.symbolName!
                highLbl.text = "high : \(symbol.high!.asLocaleCurrency)"
                lowLbl.text = "low : \(symbol.low!.asLocaleCurrency)"
                closeLbl.text = "close : \(symbol.close!.asLocaleCurrency)"
                volumeLbl.text = "volume \(symbol.volume!)"
                tickerLogo.image = UIImage(named: "\(symbol.symbolName!.uppercased()).jpg")
            }
        }
    }
}
