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
            self.rootViewController = appDelegate.loginController
        default:
            self.rootViewController = appDelegate.registerController
        }
    }
}
