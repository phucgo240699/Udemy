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
    
    var logOutBarButton: UIBarButtonItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .brown
        navigationItem.title = "Account"
        
        initializeLogOutBarButton()
    }
    
    @objc func logOutBarButtonPressed(_ sender: UIBarButtonItem) {
        guard let appDelegate = (UIApplication.shared.delegate as? AppDelegate) else {
            return
        }
        guard let fromView = appDelegate.mainTabBarController?.view else {
            return
        }
        
        UIView.transition(from: fromView, to: appDelegate.loginController.view, duration: 0.5, options: .transitionFlipFromRight) { (isSuccess) in
            if isSuccess {
                appDelegate.window?.setController(.login)
            }
        }
    }
}
