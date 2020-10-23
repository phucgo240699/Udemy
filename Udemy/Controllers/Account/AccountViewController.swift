//
//  AccountViewController.swift
//  Udemy
//
//  Created by Phúc Lý on 10/1/20.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import Alamofire
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
    var titles: [String] = ["Account Info", "Avatar", "Change Password", "Payment history"]
    
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
        navigationController?.navigationBar.barTintColor = Common.color.blue
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [ .foregroundColor: UIColor.white ]
        view.backgroundColor = .systemBackground
        
        initializeBanner()
        initializeAvatarImgView()
        initializeNameLabel()
        initializeEmailLabel()
        
        initializeTableView()
        
        initializeLogOutBarButton()
    }
    
    // Actions
    @objc func logOutBarButtonPressed(_ sender: UIBarButtonItem) {
        logOut()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "accountSettingTBVCell", for: indexPath) as! SimpleTableViewCell
        cell.selectionStyle = .none
        cell.accessoryType = .disclosureIndicator
        cell.imgView?.image = UIImage(systemName: icons[indexPath.row])
        cell.label?.text = titles[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Info
        if indexPath.row == 0 {
            let infoVC = InformationViewController()
            infoVC.updateInfoSuccessfully = { newName in
                self.nameLbl?.text = newName
            }
            navigationController?.pushViewController(infoVC, animated: true)
        }
        
        // Avatar
        else if indexPath.row == 1 {
            let avatarVC = AvatarViewController()
            avatarVC.updateAvatarSuccessfully = { image in
                self.avatarImgView?.image = image
            }
            
            navigationController?.pushViewController(avatarVC, animated: true)
        }
        
        // Password
        else if indexPath.row == 2 {
            navigationController?.pushViewController(PasswordViewController(), animated: true)
        }
        
    }
    
}


// MARK: - Function Supports
extension AccountViewController {
    func fetchAvatarToAccount(_ urlString: String) {
        guard let appDelegate = (UIApplication.shared.delegate as? AppDelegate) else {
            return
        }
        
        // Default
        if appDelegate.account.imageName == "default.jpg" {
            guard let defaultImage = UIImage(named: Common.imageName.logo) else {
                return
            }
            
            appDelegate.account.avatar = defaultImage
        }
        
        // Others
        else {
            guard let url = URL(string: urlString) else {
                return
            }
            AF.request(url, method: .get).response { (response) in
                
                guard let data = response.data else {
                    return
                }
                if let image = UIImage(data: data) {
                    appDelegate.account.avatar = image
                }
            }
        }
    }
}
