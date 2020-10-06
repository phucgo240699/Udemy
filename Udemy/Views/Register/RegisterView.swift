//
//  RegisterView.swift
//  Udemy
//
//  Created by Phúc Lý on 9/29/20.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import Foundation
import UIKit

extension RegisterViewController {
    func initializeCloseButton() {
        
        // Initialize
        closeBtn = UIButton(nil, nil, nil, UIImage(systemName: "arrow.left"))
        
        // Unwrap
        guard let closeBtn = closeBtn else {
            return
        }
        
        // Add target
        closeBtn.addTarget(self, action: #selector(RegisterViewController.closeBtnPressed(_:)), for: .touchUpInside)
        
        // Constraints
        let edge = width * (UIDevice.current.userInterfaceIdiom == .phone ? 0.08 : 0.05)
        closeBtn.addToViewByConstraints(parent: view,
                                      top: YAnchor(direction: view.topAnchor, constant: 44.0),
                                      bottom: nil,
                                      leading: XAnchor(direction: view.leadingAnchor, constant: 2 * marginSpace),
                                      trailing: nil,
                                      centerY: nil,
                                      centerX: nil,
                                      width: edge,
                                      height: edge)
        
    }
    
    // TextFields
    func initializeTextField(_ textField: inout UITextField?, _ placeholder: String, _ topView: UIView?) {
        // Initialize
        textField = UITextField(placeholder: placeholder)
        
        // Unwrap
        guard let textField = textField, let topView = topView else {
            return
        }
        
        // Assign delegate property to self
        textField.delegate = self
        
        
        // Constraints
        textField.addToViewByConstraints(parent: view,
                                      top: YAnchor(direction: topView.bottomAnchor, constant: height * 0.02),
                                      bottom: nil,
                                      leading: XAnchor(direction: view.leadingAnchor, constant: view.bounds.width * 0.05),
                                      trailing: XAnchor(direction: view.trailingAnchor, constant: -view.bounds.width * 0.05),
                                      centerY: nil,
                                      centerX: XAnchor(direction: view.centerXAnchor, constant: 0),
                                      width: nil,
                                      height: heightTextField)
        
        
        // Beauty
        textField.afterEffect(fontSize: heightTextField * 0.4, corner: heightTextField * 0.5)
    }
    
    // Register Button
    func initializeRegisterButton() {
        registerBtn = UIButton("Register", Common.color.blue, .white, nil)
        guard let registerBtn = registerBtn, let rePasswordTxtField = rePasswordTxtField else {
            return
        }
        
        registerBtn.addToViewByConstraints(parent: view,
                                      top: YAnchor(direction: rePasswordTxtField.bottomAnchor, constant: 4 * marginSpace),
                                      bottom: nil,
                                      leading: nil,
                                      trailing: nil,
                                      centerY: nil,
                                      centerX: XAnchor(direction: view.centerXAnchor, constant: 0),
                                      width: widthRegisterButton,
                                      height: heightRegisterButton)
        
        registerBtn.afterEffect(textSize: heightRegisterButton * 0.5, corner: heightRegisterButton * 0.2)
        registerBtn.addTarget(self, action: #selector(RegisterViewController.registerBtnPressed(_:)), for: .touchUpInside)
    }
}
