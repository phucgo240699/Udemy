//
//  MainTabBarController.swift
//  Udemy
//
//  Created by Phúc Lý on 10/1/20.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import Foundation
import UIKit

class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTabBar()
    }
    
    func setUpTabBar() {
        
        let forum = FeatureViewController()
        forum.tabBarItem = UITabBarItem(title: nil, image: nil, tag: 0)
        forum.tabBarItem.image = UIImage(named: "star")
        forum.tabBarItem.imageInsets = UIEdgeInsets(top: 7, left: 0, bottom: -7, right: 0)
        forum.tabBarItem.selectedImage = UIImage(named: "star.fill")
        
        let feed = UINavigationController(rootViewController: SearchViewController())
        feed.tabBarItem = UITabBarItem(title: nil, image: nil, tag: 0)
        feed.tabBarItem.image = UIImage(named: "magnifyingglass")
        feed.tabBarItem.imageInsets = UIEdgeInsets(top: 7, left: 0, bottom: -7, right: 0)
        feed.tabBarItem.selectedImage = UIImage(named: "magnifyingglass")
        
        let event = UINavigationController(rootViewController: CourseViewController())
        event.tabBarItem = UITabBarItem(title: nil, image: nil, tag: 0)
        event.tabBarItem.image = UIImage(named: "square.stack.3d.up")
        event.tabBarItem.imageInsets = UIEdgeInsets(top: 7, left: 0, bottom: -7, right: 0)
        event.tabBarItem.selectedImage = UIImage(named: "square.stack.3d.up.fill")
        
        let notification = UINavigationController(rootViewController: CartViewController())
        notification.tabBarItem = UITabBarItem(title: nil, image: nil, tag: 0)
        notification.tabBarItem.image = UIImage(named: "cart")
        notification.tabBarItem.imageInsets = UIEdgeInsets(top: 7, left: 0, bottom: -7, right: 0)
        notification.tabBarItem.selectedImage = UIImage(named: "cart.fill")
        
        let setting = UINavigationController(rootViewController: AccountViewController())
        setting.tabBarItem = UITabBarItem(title: nil, image: nil, tag: 0)
        setting.tabBarItem.image = UIImage(named: "account")
        setting.tabBarItem.imageInsets = UIEdgeInsets(top: 7, left: 0, bottom: -7, right: 0)
        setting.tabBarItem.selectedImage = UIImage(named: "account.fill")
        
        
        self.viewControllers = [forum, feed, event, notification, setting]
    }
}
