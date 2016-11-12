//
//  TipsVC.swift
//  Investment Hero
//
//  Created by Alex Nguyen on 2016-11-12.
//  Copyright © 2016 Alex Nguyen. All rights reserved.
//

import UIKit

class TipsVC: UIViewController {

    var tips : [String]?
    
    @IBOutlet weak var tipContainer : MaterialView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tipContainer.changeShadowColour(to: UIColor.black)
        self.view.backgroundColor = COLOUR_SCHEME
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func generateTips() {
        self.tips = [String]()
        var tip = "As a new investor, be prepared to take some small losses."
                tips?.append(tip)
        tip = "Always cut your losses at 8% below your purchase price."
                tips?.append(tip)
        tip = "Persistence is key when learning to invest. Don’t get discouraged."
                tips?.append(tip)
        tip = "Learning to invest doesn’t happen overnight. It takes time and effort to become successful at it."
                tips?.append(tip)
        tip = "When getting started, it is important that you pick the right full service or discount brokerage. If you use a broker, make sure he or she has a good track record."
                tips?.append(tip)
        tip = "It only takes $500 to $1,000 to get started. Experience is a great teacher."
                tips?.append(tip)
        tip = "Avoid more volatile types of investments, such as futures, options, and foreign stocks."
                tips?.append(tip)
        tip = "Concentrate on a few, high-quality stocks. There’s no need to own twenty or more stocks."
                tips?.append(tip)
        tip = "Don’t get emotionally involved with your stocks. Follow a set of buying and selling rules, and don’t let your emotions change your mind"
                tips?.append(tip)
        tip = "Don’t buy a stock under $15 a share. The best companies that are leaders in their fields simply do not come at $5 or $10 per share."
                tips?.append(tip)
        tip = "Learning from the best stock market winners can guide you to tomorrow’s leaders. "
                tips?.append(tip)
        tip = "Always do a post-analysis of your stock market trades so that you can learn from your successes and mistakes."
                tips?.append(tip)
        tip = "A combination of fundamental and technical investment styles is essential to picking winning stocks."
                tips?.append(tip)
        tip = "Fundamental analysis looks at a company’s earnings, earnings growth, sales, profit margins, and return on equity among other things. It helps narrow down your choices so that you are only dealing with quality stocks."
                tips?.append(tip)

    }
}
