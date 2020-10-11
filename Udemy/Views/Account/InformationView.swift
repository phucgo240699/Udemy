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
        textView = UITextView()
        // Unwrap
        guard let textView = textView, let topAnchor = topAnchor else {
            return
        }
        
        textView.backgroundColor = .systemBackground
        
        if text != nil {
            textView.text = text
            textView.textColor = Common.color.textColor
        }
        else {
            textView.text = placeholder
            textView.textColor = .placeholderText
        }
        // Constraints
        textView.addToViewByConstraints(parent: view,
                                      top: YAnchor(direction: topAnchor, constant: topConstant),
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
    func initializeBtnField(_ button: inout UIButton?, _ title: String?, _ placeholder: String, _ topAnchor: NSLayoutYAxisAnchor?, _ topConstant: CGFloat) {
        // Initialize
        button = UIButton()
        button?.backgroundColor = .systemBackground
        button?.titleLabel?.textAlignment = .left
        button?.setTitle(title ?? "Gender", for: .normal)
        if title != nil {
            button?.setTitleColor( Common.color.textColor, for: .normal)
        }
        else {
            button?.setTitleColor( .placeholderText, for: .normal)
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
    
    
    // Update Button
    func initializeUpdateButton() {
        updateBtn = UIButton("Update", Common.color.blue, .white, nil)
        guard let updateBtn = updateBtn, let descriptionTxtView = descriptionTxtView else {
            return
        }
        
        updateBtn.addToViewByConstraints(parent: view,
                                      top: YAnchor(direction: descriptionTxtView.bottomAnchor, constant: 4 * marginSpace),
                                      bottom: nil,
                                      leading: nil,
                                      trailing: nil,
                                      centerY: nil,
                                      centerX: XAnchor(direction: view.centerXAnchor, constant: 0),
                                      width: widthRegisterButton,
                                      height: heightRegisterButton)
        
        updateBtn.afterEffect(textSize: heightRegisterButton * 0.5, corner: heightRegisterButton * 0.2)
        updateBtn.addTarget(self, action: #selector(InformationViewController.updateBtnPressed(_:)), for: .touchUpInside)
    }
}
