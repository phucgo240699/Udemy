//
//  AccountViewController.swift
//  Udemy
//
//  Created by Phúc Lý on 10/1/20.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import Foundation
import UIKit

class AccountViewController: UIViewController {
    
    // Banner Area
    var bannerView: UIView?
    var avatarImgView: UIImageView?
    var nameLbl: UILabel?
    var emailLbl: UILabel?
    
    
    // Options Area
//    var infoBtn: UIButton?
//    var avatarBtn: UIButton?
//    var secureBtn: UIButton?
//    var paymentHistoryBtn: UIButton?
    var tableView: UITableView?
    var icons: [String] = ["person", "photo", "checkmark.shield", "creditcard"]
    var titles: [String] = ["Account Info", "Avatar", "Security", "Payment history"]
    
    var logOutBarButton: UIBarButtonItem?
    
    var width:CGFloat {
        get {
            return self.view.bounds.width
        }
    }
    var height: CGFloat {
        get {
            return self.view.bounds.height
        }
    }
    var navBarHeight: CGFloat {
        get {
            return navigationController?.navigationBar.bounds.height ?? 44
        }
    }
    
    var account: Account? {
        get {
            guard let appDelegate = (UIApplication.shared.delegate as? AppDelegate) else {
                return nil
            }
            return appDelegate.account
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Account"
        view.backgroundColor = .systemBackground
        
        initializeBanner()
        initializeAvatarImgView()
        initializeNameLabel()
        initializeEmailLabel()
        
        initializeTableView()
        
        initializeLogOutBarButton()
    }
    
    @objc func logOutBarButtonPressed(_ sender: UIBarButtonItem) {
        guard let appDelegate = (UIApplication.shared.delegate as? AppDelegate) else {
            return
        }
        appDelegate.account.release()
        appDelegate.window?.setController(.login)
    }
}


// MARK: - Tableview Delegates
extension AccountViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return height * 0.07
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "accountCell", for: indexPath) as! SimpleTableViewCell
        cell.selectionStyle = .none
        cell.imgView?.image = UIImage(systemName: icons[indexPath.row])
        cell.label?.text = titles[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            navigationController?.pushViewController(InformationViewController(), animated: true)
        }
    }
    
}
