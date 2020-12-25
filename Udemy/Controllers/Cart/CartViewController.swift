//
//  CartViewController.swift
//  Udemy
//
//  Created by Phúc Lý on 17/11/2020.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import UIKit
import SVProgressHUD

fileprivate let cellID: String = "orderedCourseTBVCell"
fileprivate let cellHeight: CGFloat = 220.0

class CartViewController: UIViewController {
    

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lbEmpty: UILabel!
    
    var refreshControl: UIRefreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationItem.title = "Cart"
        
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let appDelegate = (UIApplication.shared.delegate as? AppDelegate) else {
            return
        }
        
        if appDelegate.cart.courses.count == 0 {
            tableView.isHidden = true
            lbEmpty.isHidden = false
        }
        else {
            tableView.isHidden = false
            lbEmpty.isHidden = true
        }
    }

    func setupUI() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "OrderedCourseTableViewCell", bundle: nil), forCellReuseIdentifier: cellID)
        
        // Refresh
        refreshControl.addTarget(self, action: #selector(CartViewController.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
        
    }
    
    @objc func refresh(_ sender: UIRefreshControl) {
        refreshControl.endRefreshing()
        
        self.tableView.reloadData()
    }
}


// MARK: UITableViewDatasource
extension CartViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let appDelegate = (UIApplication.shared.delegate as? AppDelegate) else {
            return 0
        }
        return appDelegate.cart.courses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let appDelegate = (UIApplication.shared.delegate as? AppDelegate) else {
            return UITableViewCell()
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? OrderedCourseTableViewCell else {
            return UITableViewCell()
        }
        
        cell.onTapPaymentBtn = {
            RequestAPI.shared.getPaymentKey { (key) in
                let paymentVC = PaymentViewController()
                paymentVC.name = appDelegate.account.name
                paymentVC.email = appDelegate.account.email
                paymentVC.idCourse = appDelegate.cart.courses[indexPath.row]._id
                paymentVC.idUser = appDelegate.account._id
                paymentVC.stripeToken = key
                paymentVC.onTapPayCourseSuccess = {
                    self.notificate(UIImage(named: Common.imageName.done), "Paid successfully", "")
                }
                self.navigationController?.pushViewController(paymentVC, animated: true)
            }
        }
        cell.setData(course: appDelegate.cart.courses[indexPath.row])
        
        return cell
    }
    
    
}

// MARK: UITableViewDelegate
extension CartViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Did select")
    }
}
