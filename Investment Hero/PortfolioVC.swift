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
        //Login to Firebase
        DataService.shared.signInAnonymously()
        
        //Get orders (or use stub data)
        UserdataService.shared.getOrders()
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
