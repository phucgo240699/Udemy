//
//  Window.swift
//  Udemy
//
//  Created by Phúc Lý on 9/30/20.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import Foundation
import UIKit
extension UIWindow {
    func setController(_ value: CurrentController) {
        let appDelegate = (UIApplication.shared.delegate as! AppDelegate)
        switch value {
        case .login:
            appDelegate.currentController = .login
            self.rootViewController = appDelegate.loginController
        case .register:
            appDelegate.currentController = .register
            if appDelegate.registerController == nil {
                appDelegate.registerController = RegisterViewController()
            }
            self.rootViewController = appDelegate.registerController
        default:
            appDelegate.currentController = .mainTab
            if appDelegate.mainTabBarController == nil {
                appDelegate.mainTabBarController = MainTabBarController()
            }
            self.rootViewController = appDelegate.mainTabBarController
        }
    }
}
