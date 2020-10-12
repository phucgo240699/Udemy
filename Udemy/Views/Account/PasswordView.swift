//
//  PasswordView.swift
//  Udemy
//
//  Created by Phúc Lý on 10/12/20.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import UIKit

extension PasswordViewController {
    
    // TextFields
    func initializeTextField(_ textField: inout UITextField?, _ text: String?, _ placeholder: String, _ topAnchor: NSLayoutYAxisAnchor?, _ topConstant: CGFloat, keyType: UIKeyboardType = UIKeyboardType.default, isHideText: Bool = false) {
        // Initialize
        textField = UITextField(text: text ?? "", keyType: keyType, isHideText: isHideText)

        // Unwrap
        guard let textField = textField, let topAnchor = topAnchor else {
            return
        }
        
        textField.placeholder = placeholder
        
        // Assign delegate property to self
        textField.delegate = self
        
        
        // Constraints
        textField.addToViewByConstraints(parent: view,
                                      top: YAnchor(direction: topAnchor, constant: topConstant),
                                      bottom: nil,
                                      leading: XAnchor(direction: view.leadingAnchor, constant: view.bounds.width * 0.05),
                                      trailing: XAnchor(direction: view.trailingAnchor, constant: -view.bounds.width * 0.05),
                                      centerY: nil,
                                      centerX: XAnchor(direction: view.centerXAnchor, constant: 0),
                                      width: nil,
                                      height: heightTextField)
        
        textField.font = UIFont(name: Common.fontName, size: heightTextField * 0.4)
    }
    
    
    // Bottom Button
    func initializeBottomButton(_ button: inout UIButton?, _ title: String, _ topAnchor: NSLayoutYAxisAnchor?, _ topConstant: CGFloat) {
        button = UIButton(title, Common.color.blue, .white, nil)
        guard let button = button, let topAnchor = topAnchor else {
            return
        }
        
        button.addToViewByConstraints(parent: view,
                                      top: YAnchor(direction: topAnchor, constant: topConstant),
                                      bottom: nil,
                                      leading: nil,
                                      trailing: nil,
                                      centerY: nil,
                                      centerX: XAnchor(direction: view.centerXAnchor, constant: 0),
                                      width: widthUpdateButton,
                                      height: heightUpdateButton)
        
        button.afterEffect(textSize: heightUpdateButton * 0.5, corner: heightUpdateButton * 0.2)
        button.addTarget(self, action: #selector(PasswordViewController.updateBtnPressed(_:)), for: .touchUpInside)
    }
}
