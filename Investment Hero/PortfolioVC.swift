//
//  ViewController.swift
//  Investment Hero
//
//  Created by Alex Nguyen on 2016-11-11.
//  Copyright © 2016 Alex Nguyen. All rights reserved.
//

import UIKit

class PortfolioVC: UIViewController {

    @IBOutlet weak var tableView : UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    //MARK : Initializers
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
}
extension PortfolioVC : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: PORTFOLIO_CELL, for: indexPath) as? PortfolioCell {
            return cell
        }
        return UITableViewCell()
    }
}
