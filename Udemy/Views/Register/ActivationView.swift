//
//  ActivationView.swift
//  Udemy
//
//  Created by Phúc Lý on 10/6/20.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import Foundation
import UIKit

extension ActivationViewController {
    func initializeCloseButton() {
        // Initialize
        closeBtn = UIButton(nil, nil, nil, UIImage(named: "arrow.left"))
        
        // Unwrap
        guard let closeBtn = closeBtn else {
            return
        }
        
        // Add target
        closeBtn.addTarget(self, action: #selector(ActivationViewController.closeBtnPressed(_:)), for: .touchUpInside)
        
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
    func initializeTextField(_ textField: inout UITextField?, _ placeholder: String, _ topView: UIView?, _ topConstant: CGFloat, keyType: UIKeyboardType = UIKeyboardType.default, isHideText: Bool = false) {
        // Initialize
        textField = UITextField(placeholder: placeholder, keyType: keyType, isHideText: isHideText)
        
        // Unwrap
        guard let textField = textField, let topView = topView else {
            return
        }
        
        // Constraints
        textField.addToViewByConstraints(parent: view,
                                      top: YAnchor(direction: topView.bottomAnchor, constant: topConstant),
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
    func initializeActivationButton() {
        activationBtn = UIButton("Activate", Common.color.lightRed, .white, nil)
        guard let activationBtn = activationBtn, let activationTxtField = activationTxtField else {
            return
        }
        
        activationBtn.addToViewByConstraints(parent: view,
                                      top: YAnchor(direction: activationTxtField.bottomAnchor, constant: 3 * marginSpace),
                                      bottom: nil,
                                      leading: nil,
                                      trailing: nil,
                                      centerY: nil,
                                      centerX: XAnchor(direction: view.centerXAnchor, constant: 0),
                                      width: widthRegisterButton,
                                      height: heightRegisterButton)
        
        activationBtn.afterEffect(textSize: heightRegisterButton * 0.5, corner: heightRegisterButton * 0.2)
        activationBtn.addTarget(self, action: #selector(ActivationViewController.activationBtnPressed(_:)), for: .touchUpInside)
    }
}

