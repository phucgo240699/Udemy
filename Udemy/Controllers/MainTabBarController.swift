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
        
        let feature = UINavigationController(rootViewController: FeatureViewController())
        feature.tabBarItem = UITabBarItem(title: nil, image: nil, tag: 0)
        feature.tabBarItem.image = UIImage(named: Common.imageName.star)
        feature.tabBarItem.imageInsets = UIEdgeInsets(top: 7, left: 0, bottom: -7, right: 0)
        feature.tabBarItem.selectedImage = UIImage(named: Common.imageName.star_fill)
        
        let search = UINavigationController(rootViewController: SearchViewController())
        search.tabBarItem = UITabBarItem(title: nil, image: nil, tag: 0)
        search.tabBarItem.image = UIImage(named: Common.imageName.magnifying_glass)
        search.tabBarItem.imageInsets = UIEdgeInsets(top: 7, left: 0, bottom: -7, right: 0)
        search.tabBarItem.selectedImage = UIImage(named: Common.imageName.magnifying_glass)
        
        let course = UINavigationController(rootViewController: CourseViewController())
        course.tabBarItem = UITabBarItem(title: nil, image: nil, tag: 0)
        course.tabBarItem.image = UIImage(named: Common.imageName.square_stack)
        course.tabBarItem.imageInsets = UIEdgeInsets(top: 7, left: 0, bottom: -7, right: 0)
        course.tabBarItem.selectedImage = UIImage(named: Common.imageName.square_stack_fill)
        
        let cart = UINavigationController(rootViewController: CartViewController())
        cart.tabBarItem = UITabBarItem(title: nil, image: nil, tag: 0)
        cart.tabBarItem.image = UIImage(named: Common.imageName.cart)
        cart.tabBarItem.imageInsets = UIEdgeInsets(top: 7, left: 0, bottom: -7, right: 0)
        cart.tabBarItem.selectedImage = UIImage(named: Common.imageName.cart_fill)
        
        let account = UINavigationController(rootViewController: AccountViewController())
        account.tabBarItem = UITabBarItem(title: nil, image: nil, tag: 0)
        account.tabBarItem.image = UIImage(named: Common.imageName.account)
        account.tabBarItem.imageInsets = UIEdgeInsets(top: 7, left: 0, bottom: -7, right: 0)
        account.tabBarItem.selectedImage = UIImage(named: Common.imageName.account_fill)
        
        
        self.viewControllers = [feature, search, course, cart, account]
    }
}
