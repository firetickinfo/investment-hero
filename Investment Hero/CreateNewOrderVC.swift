//
//  CreateNewOrderVC.swift
//  Investment Hero
//
//  Created by Alex Nguyen on 2016-11-11.
//  Copyright © 2016 Alex Nguyen. All rights reserved.
//

import UIKit

protocol NewOrderDelegate {
    func dismissNewOrderScreen()
}

class CreateNewOrderVC: UIViewController {

    @IBOutlet weak var popUpView: MaterialView!
    @IBOutlet weak var searchField : MaterialTextField!
    @IBOutlet weak var nextBtn : UIButton!
    @IBOutlet weak var searchBtn : UIButton!
    
    var delegate : NewOrderDelegate?
    var currentCard : SymbolCard?
    var isOnPreviewScreen = false
    var previewCard : PreviewOrderCard?
    var selectedSymbol : Symbol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        self.popUpView.layer.cornerRadius = 0
        self.popUpView.layer.shadowOpacity = 0.8
        self.popUpView.layer.shadowOffset = CGSize(width : 0.0, height : 0.0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override var prefersStatusBarHidden : Bool {
        return true
    }
    func removeAnimate()
    {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0;
        }, completion:{(finished : Bool)  in
            if (finished)
            {
                self.view.removeFromSuperview()
                self.dismiss(animated: false, completion: nil)
            }
        });
    }
    func createCardFromNib() -> SymbolCard? {
        return Bundle.main.loadNibNamed("SymbolCard", owner: self, options: nil)?[0] as? SymbolCard
    }
    func createPreviewCardFromNib() -> PreviewOrderCard? {
        return Bundle.main.loadNibNamed("PreviewOrderCard", owner: self, options: nil)?[0] as? PreviewOrderCard
    }
    func showNextCard(withSymbol symbol : Symbol?) {
        if let current = currentCard {
            let cardToRemove = current
            currentCard = nil
            AnimationEngine.animateToPosition(view: cardToRemove, position: AnimationEngine.offScreenLeftPosition, completion: { (_, _) in
                cardToRemove.removeFromSuperview()
            })
        }
        if let symbolCard = self.createCardFromNib() {
            self.currentCard = symbolCard
            symbolCard.setupCard(withSymbol: symbol)
            symbolCard.center = AnimationEngine.offScreenRightPosition
            self.view.addSubview(symbolCard)
            AnimationEngine.animateToPosition(view : symbolCard, position: AnimationEngine.screenCenterPosition, completion: { (_, _) in
                
            })
        }
    }
    @IBAction func cancelBtnPressed(_ sender: AnyObject) {
        delegate?.dismissNewOrderScreen()
        self.removeAnimate()
    }
    @IBAction func searchBtnPressed(_ sender: AnyObject) {
        dismissKeyboard()
        if let symbolQuery = searchField.text, symbolQuery != "" {
            WebService.shared.searchForSymbol(withSymbol: symbolQuery, completion: { (found, symbol) in
                self.selectedSymbol = symbol
                if found {
                    self.showNextCard(withSymbol: symbol)
                    self.nextBtn.isHidden = false
                } else {
                    self.showNextCard(withSymbol: nil)
                    self.nextBtn.isHidden = true
                }
            })
        }
    }
    @IBAction func nextBtnPressed(_ sender: AnyObject) {
        if !isOnPreviewScreen {
            isOnPreviewScreen = true
            AnimationEngine.animateToPosition(view: searchField, position: AnimationEngine.offScreenLeftPosition, completion: { (_, _) in
                self.searchField.isHidden = true
            })
            AnimationEngine.animateToPosition(view: self.searchBtn, position: AnimationEngine.offScreenRightPosition, completion: { (_, _) in
                self.searchField.isHidden = true
                self.searchBtn.isHidden = true
                self.searchBtn.removeFromSuperview()
            })
            AnimationEngine.animateToPosition(view: self.currentCard!, position: CGPoint(x: UIScreen.main.bounds.midX, y: 125), completion: { (_, _) in
                self.searchField.isHidden = true
                if let previewCard = self.createPreviewCardFromNib(){
                    previewCard.center = AnimationEngine.offScreenRightPosition
                    self.previewCard = previewCard
                    self.previewCard?.delegate = self
                    self.view.addSubview(previewCard)
                    AnimationEngine.animateToPosition(view : previewCard, position: AnimationEngine.screenCenterPosition, completion: { (_, _) in
                    })
                }
            })
        } else {
            self.previewCard?.createOrder(withSymbol: self.selectedSymbol)
        }
    }
}

extension CreateNewOrderVC : PreviewOrderCardDelegate {
    func didCreateOrder() {
        delegate?.dismissNewOrderScreen()
        self.removeAnimate()
    }
}
