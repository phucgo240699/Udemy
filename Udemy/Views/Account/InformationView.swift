//
//  InformationView.swift
//  Udemy
//
//  Created by Phúc Lý on 10/11/20.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import UIKit

extension InformationViewController {
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
    
    // TextView
    func initializeTextView(_ textView: inout UITextView?, _ text: String?, _ placeholder: String, _ topAnchor: NSLayoutYAxisAnchor?, _ topConstant: CGFloat) {
        // Initialize
        let label = UILabel()
        label.text = "Description:"
        label.textAlignment = .natural
        if #available(iOS 13.0, *) {
            label.textColor = .placeholderText
        } else {
            // Fallback on earlier versions
            label.textColor = .lightGray
        }
        
        textView = UITextView()
        // Unwrap
        guard let textView = textView, let topAnchor = topAnchor else {
            return
        }
        
        if #available(iOS 13.0, *) {
            textView.backgroundColor = .systemBackground
        } else {
            // Fallback on earlier versions
            textView.backgroundColor = .white
        }
        
        textView.text = text
        textView.textColor = Common.color.textColor
        
        // Constraints
        label.addToViewByConstraints(parent: view,
                                     top: YAnchor(direction: topAnchor, constant: topConstant),
                                     bottom: nil,
                                     leading: XAnchor(direction: view.leadingAnchor, constant: view.bounds.width * 0.05),
                                     trailing: XAnchor(direction: view.trailingAnchor, constant: -view.bounds.width * 0.05),
                                     centerY: nil,
                                     centerX: XAnchor(direction: view.centerXAnchor, constant: 0),
                                     width: nil,
                                     height: 1.5 * marginSpace)
        textView.addToViewByConstraints(parent: view,
                                        top: YAnchor(direction: label.bottomAnchor, constant: marginSpace/2),
                                      bottom: nil,
                                      leading: XAnchor(direction: view.leadingAnchor, constant: view.bounds.width * 0.05),
                                      trailing: XAnchor(direction: view.trailingAnchor, constant: -view.bounds.width * 0.05),
                                      centerY: nil,
                                      centerX: XAnchor(direction: view.centerXAnchor, constant: 0),
                                      width: nil,
                                      height: heightTextView)
        label.font = UIFont(name: Common.fontName, size: 1.5 * marginSpace)
        textView.afterEffect(fontSize: heightTextField * 0.4, corner: heightTextField * 0.1)
    }
    
    // Button Field
    func initializeBtnField(_ button: inout UIButton?, _ title: String?, _ placeholder: String, _ topAnchor: NSLayoutYAxisAnchor?, _ topConstant: CGFloat) {
        // Initialize
        button = UIButton()
        button?.backgroundColor = Common.color.backgroundColor
        button?.titleLabel?.textAlignment = .left
        button?.setTitle(title ?? "Gender", for: .normal)
        if title != nil {
            button?.setTitleColor( Common.color.textColor, for: .normal)
        }
        else {
            if #available(iOS 13.0, *) {
                button?.setTitleColor( .placeholderText, for: .normal)
            } else {
                // Fallback on earlier versions
                button?.setTitleColor( .lightGray, for: .normal)
            }
        }
        // Unwrap
        guard let button = button, let topAnchor = topAnchor else {
            return
        }
        
        // Constraints
        button.addToViewByConstraints(parent: view,
                                      top: YAnchor(direction: topAnchor, constant: topConstant),
                                      bottom: nil,
                                      leading: XAnchor(direction: view.leadingAnchor, constant: view.bounds.width * 0.05),
                                      trailing: XAnchor(direction: view.trailingAnchor, constant: -view.bounds.width * 0.05),
                                      centerY: nil,
                                      centerX: XAnchor(direction: view.centerXAnchor, constant: 0),
                                      width: nil,
                                      height: heightTextField)
        
        
        // Beauty
        button.afterEffect(textSize: heightTextField * 0.4, corner: heightTextField * 0.1)
        button.addTarget(self, action: #selector(InformationViewController.genderBtnPressed(_:)), for: .touchUpInside)
        
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
