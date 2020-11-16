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
        
        let forum = UINavigationController(rootViewController: FeatureViewController())
        forum.tabBarItem = UITabBarItem(title: nil, image: nil, tag: 0)
        forum.tabBarItem.image = UIImage(named: Common.imageName.star)
        forum.tabBarItem.imageInsets = UIEdgeInsets(top: 7, left: 0, bottom: -7, right: 0)
        forum.tabBarItem.selectedImage = UIImage(named: Common.imageName.star_fill)
        
        let feed = UINavigationController(rootViewController: SearchViewController())
        feed.tabBarItem = UITabBarItem(title: nil, image: nil, tag: 0)
        feed.tabBarItem.image = UIImage(named: Common.imageName.magnifying_glass)
        feed.tabBarItem.imageInsets = UIEdgeInsets(top: 7, left: 0, bottom: -7, right: 0)
        feed.tabBarItem.selectedImage = UIImage(named: Common.imageName.magnifying_glass)
        
        let event = UINavigationController(rootViewController: CourseViewController())
        event.tabBarItem = UITabBarItem(title: nil, image: nil, tag: 0)
        event.tabBarItem.image = UIImage(named: Common.imageName.square_stack)
        event.tabBarItem.imageInsets = UIEdgeInsets(top: 7, left: 0, bottom: -7, right: 0)
        event.tabBarItem.selectedImage = UIImage(named: Common.imageName.square_stack_fill)
        
        let notification = UINavigationController(rootViewController: CartViewController())
        notification.tabBarItem = UITabBarItem(title: nil, image: nil, tag: 0)
        notification.tabBarItem.image = UIImage(named: Common.imageName.cart)
        notification.tabBarItem.imageInsets = UIEdgeInsets(top: 7, left: 0, bottom: -7, right: 0)
        notification.tabBarItem.selectedImage = UIImage(named: Common.imageName.cart_fill)
        
        let setting = UINavigationController(rootViewController: AccountViewController())
        setting.tabBarItem = UITabBarItem(title: nil, image: nil, tag: 0)
        setting.tabBarItem.image = UIImage(named: Common.imageName.account)
        setting.tabBarItem.imageInsets = UIEdgeInsets(top: 7, left: 0, bottom: -7, right: 0)
        setting.tabBarItem.selectedImage = UIImage(named: Common.imageName.account_fill)
        
        
        self.viewControllers = [forum, feed, event, notification, setting]
    }
}
