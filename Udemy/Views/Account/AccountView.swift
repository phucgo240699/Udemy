//
//  AccountView.swift
//  Udemy
//
//  Created by Phúc Lý on 10/2/20.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import Alamofire
import UIKit

extension AccountViewController {
    func initializeBanner() {
        bannerView = UIView(frame: CGRect(x: 0, y: navBarHeight * 0.7, width: width, height: height * 0.5))
        guard let bannerView = bannerView else {
            return
        }
        view.addSubview(bannerView)
        bannerView.addGradient(colors: [Common.color.blue.cgColor, Common.color.purple.cgColor], start: CGPoint(x: 0.0, y: 0.0), end: CGPoint(x: 0.0, y: 1.0))
        bannerView.roundCorners(roundingCorners: [.bottomLeft, .bottomRight], cornerRadius: width * 0.05)
    }
    
    func initializeAvatarImgView() {
        avatarImgView = UIImageView()
        
        guard let bannerView = bannerView, let avatarImgView = avatarImgView  else {
            return
        }
        
        avatarImgView.addToViewByConstraints(parent: bannerView,
            top: nil,
            bottom: nil,
            leading: nil,
            trailing: nil,
            centerY: YAnchor(direction: bannerView.centerYAnchor, constant: 0),
            centerX: XAnchor(direction: bannerView.centerXAnchor, constant: 0),
            width: bannerView.bounds.height * 0.5,
            height: bannerView.bounds.height * 0.5)
        
        avatarImgView.layer.cornerRadius = bannerView.bounds.height * 0.25
        avatarImgView.layer.masksToBounds = true
        
        // Set image
        guard let appDelegate = (UIApplication.shared.delegate as? AppDelegate) else {
            return
        }
        guard let avatar = account?.avatar else {
            // 2. Get image from Server - (fix slow response avatar when login)
            guard let imageName = account?.imageName else {
                return
            }
            guard let url = URL(string: "\(Common.link.getAvatar)/\(imageName)") else {
                return
            }
            
            AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).response {
                    response in
                
                guard let data = response.data else {
                    return
                }
                guard let image = UIImage(data: data) else {
                    return
                }
                avatarImgView.image = image
            }
            
            return
        }
        avatarImgView.image = avatar
        
        
    }
    
    func initializeNameLabel() {
        nameLbl = UILabel()
        guard let bannerView = bannerView, let nameLbl = nameLbl, let avatarImgView = avatarImgView else {
            return
        }
        
        nameLbl.addToViewByConstraints(parent: bannerView,
            top: YAnchor(direction: avatarImgView.bottomAnchor, constant: 0),
            bottom: nil,
            leading: XAnchor(direction: bannerView.leadingAnchor, constant: 0),
            trailing: XAnchor(direction: bannerView.trailingAnchor, constant: 0),
            centerY: nil,
            centerX: nil,
            width: nil,
            height: bannerView.bounds.height * 0.1)
        
        nameLbl.text = account?.name ?? "Example"
        nameLbl.font = UIFont(name: Common.fontName, size: bannerView.bounds.height * 0.05)
        nameLbl.textAlignment = .center
        nameLbl.textColor = .white
    }
    
    func initializeEmailLabel() {
        emailLbl = UILabel()
        guard let bannerView = bannerView, let emailLbl = emailLbl, let nameLbl = nameLbl else {
            return
        }
        
        emailLbl.addToViewByConstraints(parent: bannerView,
            top: YAnchor(direction: nameLbl.bottomAnchor, constant: 0),
            bottom: nil,
            leading: XAnchor(direction: bannerView.leadingAnchor, constant: 0),
            trailing: XAnchor(direction: bannerView.trailingAnchor, constant: 0),
            centerY: nil,
            centerX: nil,
            width: nil,
            height: bannerView.bounds.height * 0.1)
        
        emailLbl.text = account?.email ?? "example@gmail.com"
        emailLbl.font = UIFont(name: Common.fontName, size: bannerView.bounds.height * 0.05)
        emailLbl.textAlignment = .center
        emailLbl.textColor = .white
    }
    
    func initializeTableView() {
        tableView = UITableView(frame: .zero, style: .grouped)
        
        guard let tableView = tableView, let bannerView = bannerView else {
            return
        }
        
        tableView.addToViewByConstraints(parent: view,
            top: YAnchor(direction: bannerView.bottomAnchor, constant: 0),
            bottom: YAnchor(direction: view.bottomAnchor, constant: (tabBarController?.tabBar.bounds.height ?? 85) * -1.0),
            leading: XAnchor(direction: view.leadingAnchor, constant: 0),
            trailing: XAnchor(direction: view.trailingAnchor, constant: 0),
            centerY: nil, centerX: nil, width: nil, height: nil)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "SimpleTableViewCell", bundle: nil), forCellReuseIdentifier: "accountCell")
    }
    
    func initializeLogOutBarButton() {
        logOutBarButton = UIBarButtonItem(title: "Log out", style: .plain, target: self, action: #selector(AccountViewController.logOutBarButtonPressed(_:)))
        logOutBarButton?.tintColor = .systemRed
        navigationItem.rightBarButtonItem = logOutBarButton
    }
}
