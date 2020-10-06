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
        forum.tabBarItem.image = UIImage(systemName: "star")
        forum.tabBarItem.imageInsets = UIEdgeInsets(top: 7, left: 0, bottom: -7, right: 0)
        forum.tabBarItem.selectedImage = UIImage(systemName: "star.fill")
        
        let feed = UINavigationController(rootViewController: SearchViewController())
        feed.tabBarItem = UITabBarItem(title: nil, image: nil, tag: 0)
        feed.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        feed.tabBarItem.imageInsets = UIEdgeInsets(top: 7, left: 0, bottom: -7, right: 0)
        feed.tabBarItem.selectedImage = UIImage(systemName: "magnifyingglass")
        
        let event = UINavigationController(rootViewController: CourseViewController())
        event.tabBarItem = UITabBarItem(title: nil, image: nil, tag: 0)
        event.tabBarItem.image = UIImage(systemName: "square.stack.3d.up")
        event.tabBarItem.imageInsets = UIEdgeInsets(top: 7, left: 0, bottom: -7, right: 0)
        event.tabBarItem.selectedImage = UIImage(systemName: "square.stack.3d.up.fill")
        
        let notification = UINavigationController(rootViewController: CartViewController())
        notification.tabBarItem = UITabBarItem(title: nil, image: nil, tag: 0)
        notification.tabBarItem.image = UIImage(systemName: "cart.badge.plus")
        notification.tabBarItem.imageInsets = UIEdgeInsets(top: 7, left: 0, bottom: -7, right: 0)
        notification.tabBarItem.selectedImage = UIImage(systemName: "cart.fill.badge.plus")
        
        let setting = UINavigationController(rootViewController: AccountViewController())
        setting.tabBarItem = UITabBarItem(title: nil, image: nil, tag: 0)
        setting.tabBarItem.image = UIImage(systemName: "person.crop.circle")
        setting.tabBarItem.imageInsets = UIEdgeInsets(top: 7, left: 0, bottom: -7, right: 0)
        setting.tabBarItem.selectedImage = UIImage(systemName: "person.crop.circle.fill")
        
        
        self.viewControllers = [forum, feed, event, notification, setting]
    }
}
