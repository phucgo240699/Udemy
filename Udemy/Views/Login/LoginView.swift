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
        UIView.addToViewByConstraints(parent: view,
            subView: imageView,
            top: YAnchor(direction: view.topAnchor, constant: navBarHeight * 1.5),
            bottom: nil, leading: nil,
            trailing: nil,
            centerY: nil,
            centerX: XAnchor(direction: view.centerXAnchor, constant: 0),
            width: width * 0.5,
            height: width * 0.5)
    }
    
    func initializeInputTextField() {
        emailTxtField = UITextField.getInput(placeholder: "\temail")
        passwordTxtField = UITextField.getInput(placeholder: "\tpassword", isHideText: true)
        
        let heightTextField = width * 0.12
        guard let email = emailTxtField, let password = passwordTxtField else {
            return
        }
        
        // Email
        UIView.addToViewByConstraints(parent: view,
            subView: email,
            top: nil,
            bottom: nil,
            leading: XAnchor(direction: view.leadingAnchor, constant: view.bounds.width * 0.05),
            trailing: XAnchor(direction: view.trailingAnchor, constant: -view.bounds.width * 0.05),
            centerY: YAnchor(direction: view.centerYAnchor, constant: 0),
            centerX: XAnchor(direction: view.centerXAnchor, constant: 0),
            width: nil,
            height: heightTextField)
        
        // Password
        UIView.addToViewByConstraints(parent: view,
            subView: password,
            top: YAnchor(direction: email.bottomAnchor, constant: 10),
            bottom: nil,
            leading: XAnchor(direction: view.leadingAnchor, constant: view.bounds.width * 0.05),
            trailing: XAnchor(direction: view.trailingAnchor, constant: -view.bounds.width * 0.05),
            centerY: nil,
            centerX: XAnchor(direction: view.centerXAnchor, constant: 0),
            width: nil,
            height: heightTextField)
        
        email.afterEffect(fontSize: heightTextField * 0.4, corner: heightTextField * 0.5)
        password.afterEffect(fontSize: heightTextField * 0.4, corner: heightTextField * 0.5)
    }
    
    func initializeLoginButton() {
        loginBtn = UIButton.getButton("Login", Common.color.lightRed, .white)
        
        let heightButton = width * 0.12
        guard let loginBtn = loginBtn, let password = passwordTxtField else {
            return
        }
        
        UIView.addToViewByConstraints(parent: view, subView: loginBtn, top: YAnchor(direction: password.bottomAnchor, constant: 20), bottom: nil, leading: nil, trailing: nil, centerY: nil, centerX: XAnchor(direction: view.centerXAnchor, constant: 0), width: width * 0.5, height: heightButton)
        
        loginBtn.afterEffect(textSize: heightButton * 0.5, corner: heightButton * 0.2)
    }
    
    func initializeRegisterButton() {
        registerBtn = UIButton.getButton("Register", nil , UIColor.link)
        
        let heightButton = height * 0.04
        guard let registerBtn = registerBtn else {
            return
        }
        
        UIView.addToViewByConstraints(parent: view,
            subView: registerBtn,
            top: nil,
            bottom: YAnchor(direction: view.bottomAnchor, constant: -20),
            leading: nil,
            trailing: nil,
            centerY: nil,
            centerX: XAnchor(direction: view.centerXAnchor, constant: 0),
            width: width * 0.2,
            height: heightButton)
        
        registerBtn.afterEffect(textSize: heightButton * 0.5, corner: 0.0)
        registerBtn.addTarget(self, action: #selector(LoginViewController.registerBtnPressed(_:)), for: .touchUpInside)
    }
}
