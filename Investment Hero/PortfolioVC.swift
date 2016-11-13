import UIKit
import Firebase
class PortfolioVC: UIViewController {

    @IBOutlet weak var totalPortfolioValue : UILabel!
    
    @IBOutlet weak var tableView : UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    @IBOutlet weak var loadingSpinner : UIActivityIndicatorView!
    
    //MARK : Initializers
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //Login to Firebase
        DataService.shared.signInAnonymously()
        totalPortfolioValue.text = ""
        registerForPreviewing(with: self, sourceView: tableView)
        loadingSpinner.isHidden = true
        //InvestingManager.shared.observeNewMessages()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadingSpinner.isHidden = false
        loadingSpinner.startAnimating()
        DataService.shared.REF_ORDERS.observe(FIRDataEventType.value, with: { (snapshot) -> Void in
            UserdataService.shared.orders = [Order]()
            let enumerator = snapshot.children
            while let orderSnapshot = enumerator.nextObject() as? FIRDataSnapshot {
                if let order = orderSnapshot.value as? Dictionary<String, AnyObject> {
                    let newOrder = Order()
                    if let purchacePrice = order[KEY_PURCHASE_PRICE] as? String {
                        newOrder.purchasePrice = Double(purchacePrice)
                    }
                    if let currentPrice = order[KEY_CURRENT_PRICE] as? String {
                        newOrder.currentPrice = Double(currentPrice)
                    }
                    if let qty = order[KEY_QUANTITY] as? String {
                        newOrder.quantity = Double(qty)
                    }
                    if let stop_loss = order[KEY_STOP_LOSS] as? String {
                        newOrder.stopLoss = Double(stop_loss)
                    }
                    if let stop_plan = order[KEY_STOP_PLAN] as? String {
                        newOrder.stopPlan = stop_plan
                    }
                    if let symbol = order[KEY_SYMBOL] as? String {
                        newOrder.symbol = symbol
                    }
                    if let take_profit = order[KEY_TAKE_PROFIT] as? String {
                        newOrder.takeProfit = Double(take_profit)
                    }
                    if let take_profit_plan = order[KEY_TAKE_PROFIT_PLAN] as? String {
                        newOrder.takeProfitPlan = take_profit_plan
                    }
                    UserdataService.shared.addOrder(withOrder: newOrder)
                }
            }
            self.loadingSpinner.stopAnimating()
            self.loadingSpinner.isHidden = true
            self.totalPortfolioValue.text = UserdataService.shared.calculateTotalPortfolioValue().asLocaleCurrency
            self.tableView.reloadData()
        })
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated. 
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }
    func footerTapped(_ sender: UITapGestureRecognizer) {
        let newOrder = CreateNewOrderVC()
        newOrder.delegate = self
        newOrder.modalTransitionStyle = .coverVertical
        newOrder.modalPresentationStyle = .overCurrentContext
        present(newOrder, animated: true, completion: nil)
    }
}
extension PortfolioVC : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UserdataService.shared.orders?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let order = UserdataService.shared.orders?[indexPath.row] else { return UITableViewCell() }
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: PORTFOLIO_CELL, for: indexPath) as? PortfolioCell {
            cell.setupCell(withOrder: order)
            return cell
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if let view = Bundle.main.loadNibNamed("PortfolioFooterView", owner: self, options: nil)?[0] as? UIView {
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.footerTapped(_:)))
            view.addGestureRecognizer(tap)
            view.isUserInteractionEnabled = true
            return view
        }
        return nil
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let view = Bundle.main.loadNibNamed("PortfolioHeaderView", owner: self, options: nil)?[0] as? UIView {
            return view
        }
        return nil
    }
}
extension PortfolioVC : NewOrderDelegate {
    func dismissNewOrderScreen() {
        print("New order screen dismissed")
    }
}
extension PortfolioVC : UIViewControllerPreviewingDelegate {
    @available(iOS 9.0, *)
    public func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        //Do your thing
    }

    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        if let indexPath = tableView.indexPathForRow(at: location) {
            guard let order = UserdataService.shared.orders?[indexPath.row] else { return nil }
            //This will show the cell clearly and blur the rest of the screen for our peek.
            previewingContext.sourceRect = tableView.rectForRow(at: indexPath)
            if let orderVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PeekOrderVC") as? PeekOrderVC {
                orderVC.setup(withOrder: order)
                return orderVC
            }
        }
        return nil
    }
}
