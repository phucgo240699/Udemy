//
//  LoginView.swift
//  Udemy
//
//  Created by Phúc Lý on 9/29/20.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import Foundation
import UIKit

extension LoginViewController {
    func initializeImageView() {
        imageView = UIImageView(image: UIImage(named: Common.imageName.logo))
        guard let imageView = imageView else {
            return
        }
        imageView.addToViewByConstraints(parent: view,
                                         top: YAnchor(direction: view.topAnchor, constant: navBarHeight * 1.5),
                                         bottom: nil, leading: nil,
                                         trailing: nil,
                                         centerY: nil,
                                         centerX: XAnchor(direction: view.centerXAnchor, constant: 0),
                                         width: width * 0.4,
                                         height: width * 0.4)
    }
    
    // TextFields
    func initializeTextField(_ textField: inout UITextField?, _ placeholder: String, _ yAnchor: YAnchor, keyType: UIKeyboardType = UIKeyboardType.default, isHideText: Bool = false) {
        // Initialize
        textField = UITextField(placeholder: placeholder, keyType: keyType, isHideText: isHideText)
        
        // Unwrap
        guard let textField = textField else {
            return
        }
        
        // Assign delegate property to self
        textField.delegate = self
        
        
        // Constraints
        textField.addToViewByConstraints(parent: view,
                                         top: yAnchor,
                                         bottom: nil,
                                         leading: XAnchor(direction: view.leadingAnchor, constant: view.bounds.width * (UIDevice.current.userInterfaceIdiom == .phone ? 0.05 : 0.2)),
                                         trailing: XAnchor(direction: view.trailingAnchor, constant: -view.bounds.width * (UIDevice.current.userInterfaceIdiom == .phone ? 0.05 : 0.2)),
                                         centerY: nil,
                                         centerX: nil,
                                         width: nil,
                                         height: heightTextField)
        
        
        // Beauty
        textField.afterEffect(fontSize: heightTextField * 0.4, corner: heightTextField * 0.5)
    }
    
    func initializeLoginButton() {
        loginBtn = UIButton("Login", Common.color.lightRed, .white, nil)
        
        guard let loginBtn = loginBtn, let password = passwordTxtField else {
            return
        }
        loginBtn.addToViewByConstraints(parent: view,
                                        top: YAnchor(direction: password.bottomAnchor, constant: 4 * marginSpace),
                                        bottom: nil,
                                        leading: nil,
                                        trailing: nil,
                                        centerY: nil,
                                        centerX: XAnchor(direction: view.centerXAnchor, constant: 0),
                                        width: widthLoginButton,
                                        height: heightLoginButton)
        
        loginBtn.afterEffect(textSize: heightLoginButton * 0.5, corner: heightLoginButton * 0.2)
        loginBtn.addTarget(self, action: #selector(LoginViewController.loginBtnPressed(_:)), for: .touchUpInside)
    }
    
    func initializeRegisterButton() {
        registerBtn = UIButton("Register", nil , UIColor.link, nil)
        
        let heightButton = height * 0.04
        guard let registerBtn = registerBtn else {
            return
        }
        
        registerBtn.addToViewByConstraints(parent: view,
                                           top: nil,
                                           bottom: YAnchor(direction: view.bottomAnchor, constant: -3.0 * marginSpace),
                                           leading: nil,
                                           trailing: nil,
                                           centerY: nil,
                                           centerX: XAnchor(direction: view.centerXAnchor, constant: 0),
                                           width: width * 0.4,
                                           height: heightButton)
        
        registerBtn.afterEffect(textSize: heightButton * 0.5, corner: 0.0)
        registerBtn.addTarget(self, action: #selector(LoginViewController.registerBtnPressed(_:)), for: .touchUpInside)
    }
    
    func initializeActiveButton() {
        activeBtn = UIButton("Active Account", nil, .link, nil)
        guard let activeBtn = activeBtn, let registerBtn = registerBtn else {
            return
        }
        
        let heightButton = height * 0.04
        activeBtn.addToViewByConstraints(parent: view,
                                         top: nil,
                                         bottom: YAnchor(direction: registerBtn.topAnchor, constant: -marginSpace),
                                         leading: nil,
                                         trailing: nil,
                                         centerY: nil,
                                         centerX: XAnchor(direction: view.centerXAnchor, constant: 0),
                                         width: width * 0.4,
                                         height: heightButton)
        
        activeBtn.afterEffect(textSize: heightButton * 0.5, corner: 0.0)
        activeBtn.addTarget(self, action: #selector(LoginViewController.activeBtnPressed(_:)), for: .touchUpInside)
    }
}

