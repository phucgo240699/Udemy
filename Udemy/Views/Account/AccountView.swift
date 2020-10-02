//
//  AccountView.swift
//  Udemy
//
//  Created by Phúc Lý on 10/2/20.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import Foundation
import UIKit

extension AccountViewController {
    func initializeLogOutBarButton() {
        logOutBarButton = UIBarButtonItem(title: "Log out", style: .plain, target: self, action: #selector(AccountViewController.logOutBarButtonPressed(_:)))
        logOutBarButton?.tintColor = .systemRed
        navigationItem.rightBarButtonItem = logOutBarButton
    }
}
