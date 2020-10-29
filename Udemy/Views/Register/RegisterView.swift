//
//  RegisterView.swift
//  Udemy
//
//  Created by Phúc Lý on 9/29/20.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import Foundation
import UIKit
import DropDown

extension RegisterViewController {
    func initializeCloseButton() {
        
        // Initialize
        closeBtn = UIButton(nil, nil, nil, UIImage(named: "arrow.left"))
        
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
    func initializeTextField(_ textField: inout UITextField?, _ placeholder: String, _ topView: UIView?, keyType: UIKeyboardType = UIKeyboardType.default, isHideText: Bool = false) {
        // Initialize
        textField = UITextField(placeholder: placeholder, keyType: keyType, isHideText: isHideText)
        
        // Unwrap
        guard let textField = textField, let topView = topView else {
            return
        }
        
        // Assign delegate property to self
        textField.delegate = self
        
        
        // Constraints
        textField.addToViewByConstraints(parent: view,
                                      top: YAnchor(direction: topView.bottomAnchor, constant: marginSpace),
                                      bottom: nil,
                                      leading: XAnchor(direction: view.leadingAnchor, constant: view.bounds.width * 0.05),
                                      trailing: XAnchor(direction: view.trailingAnchor, constant: -view.bounds.width * 0.05),
                                      centerY: nil,
                                      centerX: XAnchor(direction: view.centerXAnchor, constant: 0),
                                      width: nil,
                                      height: heightTextField)
        textField.afterEffect(fontSize: heightTextField * 0.4, corner: heightTextField * 0.3)
    }
    
    // TextView
    func initializeTextView(_ textView: inout UITextView?, _ placeholder: String, _ topView: UIView?, keyType: UIKeyboardType = UIKeyboardType.default, isHideText: Bool = false) {
        // Initialize
        textView = UITextView(placeholder)
        // Unwrap
        guard let textView = textView, let topView = topView else {
            return
        }
        
        // Delegate for placeholder
        textView.delegate = self
        
        // Constraints
        textView.addToViewByConstraints(parent: view,
                                      top: YAnchor(direction: topView.bottomAnchor, constant: marginSpace),
                                      bottom: nil,
                                      leading: XAnchor(direction: view.leadingAnchor, constant: view.bounds.width * 0.05),
                                      trailing: XAnchor(direction: view.trailingAnchor, constant: -view.bounds.width * 0.05),
                                      centerY: nil,
                                      centerX: XAnchor(direction: view.centerXAnchor, constant: 0),
                                      width: nil,
                                      height: heightTextView)
        
        textView.afterEffect(fontSize: heightTextField * 0.4, corner: heightTextField * 0.1)
    }
    
    // Button Field
    func initializeBtnField(_ button: inout UIButton?, _ title: String, _ topView: UIView?) {
        // Initialize
        button = UIButton()
        button?.backgroundColor = Common.color.backgroundColor
        button?.titleLabel?.textAlignment = .left
        button?.setTitle("\(title)", for: .normal)
        if #available(iOS 13.0, *) {
            button?.setTitleColor(.placeholderText, for: .normal)
        } else {
            // Fallback on earlier versions
            button?.setTitleColor(UIColor.white, for: .normal)
        }
        // Unwrap
        guard let button = button, let topView = topView else {
            return
        }
        
        // Constraints
        button.addToViewByConstraints(parent: view,
                                      top: YAnchor(direction: topView.bottomAnchor, constant: marginSpace),
                                      bottom: nil,
                                      leading: XAnchor(direction: view.leadingAnchor, constant: view.bounds.width * 0.05),
                                      trailing: XAnchor(direction: view.trailingAnchor, constant: -view.bounds.width * 0.05),
                                      centerY: nil,
                                      centerX: XAnchor(direction: view.centerXAnchor, constant: 0),
                                      width: nil,
                                      height: heightTextField)
        
        
        // Beauty
        button.afterEffect(textSize: heightTextField * 0.4, corner: heightTextField * 0.1)
        button.addTarget(self, action: #selector(RegisterViewController.genderBtnPressed(_:)), for: .touchUpInside)
        
    }
    
    // Register Button
    func initializeRegisterButton() {
        registerBtn = UIButton("Register", Common.color.blue, .white, nil)
        guard let registerBtn = registerBtn, let rePasswordTxtField = rePasswordTxtField else {
            return
        }
        
        registerBtn.addToViewByConstraints(parent: view,
                                      top: YAnchor(direction: rePasswordTxtField.bottomAnchor, constant: 3 * marginSpace),
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
