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
        closeBtn = UIButton(nil, nil, nil, backImage: UIImage(systemName: "arrow.left"))
        guard let closeBtn = closeBtn else {
            return
        }
        closeBtn.addTarget(self, action: #selector(RegisterViewController.closeBtnPressed(_:)), for: .touchUpInside)
        
        if UIDevice.current.userInterfaceIdiom == .phone {
            UIView.addToViewByConstraints(parent: view,
                subView: closeBtn,
                top: YAnchor(direction: view.topAnchor, constant: 44.0),
                bottom: nil,
                leading: XAnchor(direction: view.leadingAnchor, constant: 20),
                trailing: nil,
                centerY: nil,
                centerX: nil,
                width: width * 0.08,
                height: width * 0.08)
        }
        else if UIDevice.current.userInterfaceIdiom == .pad {
            UIView.addToViewByConstraints(parent: view,
                subView: closeBtn,
                top: YAnchor(direction: view.topAnchor, constant: 44.0),
                bottom: nil,
                leading: XAnchor(direction: view.leadingAnchor, constant: 2 * marginSpace),
                trailing: nil,
                centerY: nil,
                centerX: nil,
                width: width * 0.05,
                height: width * 0.05)
        }
        
    }
    
    // Name
    func initializeNameTextField() {
        nameTxtField = UITextField(placeholder: "\tName")

        guard let nameTxtField = nameTxtField, let closeBtn = closeBtn else {
            return
        }
        
        if UIDevice.current.userInterfaceIdiom == .phone {
            UIView.addToViewByConstraints(parent: view,
                subView: nameTxtField,
                top: YAnchor(direction: closeBtn.bottomAnchor, constant: 2 * marginSpace),
                bottom: nil,
                leading: XAnchor(direction: view.leadingAnchor, constant: view.bounds.width * 0.05),
                trailing: XAnchor(direction: view.trailingAnchor, constant: -view.bounds.width * 0.05),
                centerY: nil,
                centerX: XAnchor(direction: view.centerXAnchor, constant: 0),
                width: nil,
                height: heightTextField)
        }
        else if UIDevice.current.userInterfaceIdiom == .pad {
            UIView.addToViewByConstraints(parent: view,
                subView: nameTxtField,
                top: YAnchor(direction: closeBtn.bottomAnchor, constant: 2 * marginSpace),
                bottom: nil,
                leading: XAnchor(direction: view.leadingAnchor, constant: view.bounds.width * 0.05),
                trailing: XAnchor(direction: view.trailingAnchor, constant: -view.bounds.width * 0.05),
                centerY: nil,
                centerX: XAnchor(direction: view.centerXAnchor, constant: 0),
                width: nil,
                height: heightTextField)
        }
        
        
        
        nameTxtField.afterEffect(fontSize: heightTextField * 0.4, corner: heightTextField * 0.5)
    }
    
    // Gender
    func initializeGenderTextField() {
        genderTxtField = UITextField(placeholder: "\tGender")
        guard let nameTxtField = nameTxtField, let genderTxtField = genderTxtField else {
            return
        }
        if UIDevice.current.userInterfaceIdiom == .phone {
            UIView.addToViewByConstraints(parent: view,
                subView: genderTxtField,
                top: YAnchor(direction: nameTxtField.bottomAnchor, constant: 2 * marginSpace),
                bottom: nil,
                leading: XAnchor(direction: view.leadingAnchor, constant: view.bounds.width * 0.05),
                trailing: XAnchor(direction: view.trailingAnchor, constant: -view.bounds.width * 0.05),
                centerY: nil,
                centerX: XAnchor(direction: view.centerXAnchor, constant: 0),
                width: nil,
                height: heightTextField)
        }
        else if UIDevice.current.userInterfaceIdiom == .pad {
            UIView.addToViewByConstraints(parent: view,
                subView: genderTxtField,
                top: YAnchor(direction: nameTxtField.bottomAnchor, constant: 2 * marginSpace),
                bottom: nil,
                leading: XAnchor(direction: view.leadingAnchor, constant: view.bounds.width * 0.05),
                trailing: XAnchor(direction: view.trailingAnchor, constant: -view.bounds.width * 0.05),
                centerY: nil,
                centerX: XAnchor(direction: view.centerXAnchor, constant: 0),
                width: nil,
                height: heightTextField)
        }
        
        genderTxtField.afterEffect(fontSize: heightTextField * 0.4, corner: heightTextField * 0.5)
    }
    
    // Phone number
    func initializePhoneNumberTextField() {
        phoneNumbersTxtField = UITextField(placeholder: "\tPhone numbers")
        guard let genderTxtField = genderTxtField, let phoneNumbersTxtField = phoneNumbersTxtField else {
            return
        }
        
        if UIDevice.current.userInterfaceIdiom == .phone {
            UIView.addToViewByConstraints(parent: view,
                subView: phoneNumbersTxtField,
                top: YAnchor(direction: genderTxtField.bottomAnchor, constant: 2 * marginSpace),
                bottom: nil,
                leading: XAnchor(direction: view.leadingAnchor, constant: view.bounds.width * 0.05),
                trailing: XAnchor(direction: view.trailingAnchor, constant: -view.bounds.width * 0.05),
                centerY: nil,
                centerX: XAnchor(direction: view.centerXAnchor, constant: 0),
                width: nil,
                height: heightTextField)
        }
        else if UIDevice.current.userInterfaceIdiom == .pad {
            UIView.addToViewByConstraints(parent: view,
                subView: phoneNumbersTxtField,
                top: YAnchor(direction: genderTxtField.bottomAnchor, constant: 2 * marginSpace),
                bottom: nil,
                leading: XAnchor(direction: view.leadingAnchor, constant: view.bounds.width * 0.05),
                trailing: XAnchor(direction: view.trailingAnchor, constant: -view.bounds.width * 0.05),
                centerY: nil,
                centerX: XAnchor(direction: view.centerXAnchor, constant: 0),
                width: nil,
                height: heightTextField)
        }
        

        
        phoneNumbersTxtField.afterEffect(fontSize: heightTextField * 0.4, corner: heightTextField * 0.5)
    }
    
    // Address
    func initializeAddressTextField() {
        addressTxtField = UITextField(placeholder: "\tAddress")
        guard let phoneNumbersTxtField = phoneNumbersTxtField, let addressTxtField = addressTxtField else {
            return
        }
        
        if UIDevice.current.userInterfaceIdiom == .phone {
            UIView.addToViewByConstraints(parent: view,
                subView: addressTxtField,
                top: YAnchor(direction: phoneNumbersTxtField.bottomAnchor, constant: 2 * marginSpace),
                bottom: nil,
                leading: XAnchor(direction: view.leadingAnchor, constant: view.bounds.width * 0.05),
                trailing: XAnchor(direction: view.trailingAnchor, constant: -view.bounds.width * 0.05),
                centerY: nil,
                centerX: XAnchor(direction: view.centerXAnchor, constant: 0),
                width: nil,
                height: heightTextField)
        }
        else if UIDevice.current.userInterfaceIdiom == .pad {
            UIView.addToViewByConstraints(parent: view,
                subView: addressTxtField,
                top: YAnchor(direction: phoneNumbersTxtField.bottomAnchor, constant: 2 * marginSpace),
                bottom: nil,
                leading: XAnchor(direction: view.leadingAnchor, constant: view.bounds.width * 0.05),
                trailing: XAnchor(direction: view.trailingAnchor, constant: -view.bounds.width * 0.05),
                centerY: nil,
                centerX: XAnchor(direction: view.centerXAnchor, constant: 0),
                width: nil,
                height: heightTextField)
        }
        
        addressTxtField.afterEffect(fontSize: heightTextField * 0.4, corner: heightTextField * 0.5)
    }
    
    // Description
    func initializeDescriptionTextField() {
        descriptionTxtField = UITextField(placeholder: "\tDescription")
        guard let addressTxtField = addressTxtField, let descriptionTxtField = descriptionTxtField else {
            return
        }
        if UIDevice.current.userInterfaceIdiom == .phone {
            UIView.addToViewByConstraints(parent: view,
                subView: descriptionTxtField,
                top: YAnchor(direction: addressTxtField.bottomAnchor, constant: 2 * marginSpace),
                bottom: nil,
                leading: XAnchor(direction: view.leadingAnchor, constant: view.bounds.width * 0.05),
                trailing: XAnchor(direction: view.trailingAnchor, constant: -view.bounds.width * 0.05),
                centerY: nil,
                centerX: XAnchor(direction: view.centerXAnchor, constant: 0),
                width: nil,
                height: heightTextField)

        }
        else if UIDevice.current.userInterfaceIdiom == .pad {
            UIView.addToViewByConstraints(parent: view,
                subView: descriptionTxtField,
                top: YAnchor(direction: addressTxtField.bottomAnchor, constant: 2 * marginSpace),
                bottom: nil,
                leading: XAnchor(direction: view.leadingAnchor, constant: view.bounds.width * 0.05),
                trailing: XAnchor(direction: view.trailingAnchor, constant: -view.bounds.width * 0.05),
                centerY: nil,
                centerX: XAnchor(direction: view.centerXAnchor, constant: 0),
                width: nil,
                height: heightTextField)

        }
        
        descriptionTxtField.afterEffect(fontSize: heightTextField * 0.4, corner: heightTextField * 0.5)
    }
    
    // Password
    func initializePasswordTextField() {
        passwordTxtField = UITextField(placeholder: "\tPassword")
        guard let descriptionTxtField = descriptionTxtField, let passwordTxtField = passwordTxtField else {
            return
        }
        if UIDevice.current.userInterfaceIdiom == .phone {
            UIView.addToViewByConstraints(parent: view,
                subView: passwordTxtField,
                top: YAnchor(direction: descriptionTxtField.bottomAnchor, constant: 2 * marginSpace),
                bottom: nil,
                leading: XAnchor(direction: view.leadingAnchor, constant: view.bounds.width * 0.05),
                trailing: XAnchor(direction: view.trailingAnchor, constant: -view.bounds.width * 0.05),
                centerY: nil,
                centerX: XAnchor(direction: view.centerXAnchor, constant: 0),
                width: nil,
                height: heightTextField)
        }
        else if UIDevice.current.userInterfaceIdiom == .pad {
            UIView.addToViewByConstraints(parent: view,
                subView: passwordTxtField,
                top: YAnchor(direction: descriptionTxtField.bottomAnchor, constant: 2 * marginSpace),
                bottom: nil,
                leading: XAnchor(direction: view.leadingAnchor, constant: view.bounds.width * 0.05),
                trailing: XAnchor(direction: view.trailingAnchor, constant: -view.bounds.width * 0.05),
                centerY: nil,
                centerX: XAnchor(direction: view.centerXAnchor, constant: 0),
                width: nil,
                height: heightTextField)
        }
        
        passwordTxtField.afterEffect(fontSize: heightTextField * 0.4, corner: heightTextField * 0.5)
    }
    
    // RePassword
    func initializeRePasswordTextField() {
        rePasswordTxtField = UITextField(placeholder: "\tRe-password")
        guard let passwordTxtField = passwordTxtField, let rePasswordTxtField = rePasswordTxtField else {
            return
        }
        
        
        if UIDevice.current.userInterfaceIdiom == .phone {
            UIView.addToViewByConstraints(parent: view,
                subView: rePasswordTxtField,
                top: YAnchor(direction: passwordTxtField.bottomAnchor, constant: 2 * marginSpace),
                bottom: nil,
                leading: XAnchor(direction: view.leadingAnchor, constant: view.bounds.width * 0.05),
                trailing: XAnchor(direction: view.trailingAnchor, constant: -view.bounds.width * 0.05),
                centerY: nil,
                centerX: XAnchor(direction: view.centerXAnchor, constant: 0),
                width: nil,
                height: heightTextField)
        }
        else if UIDevice.current.userInterfaceIdiom == .pad {
            UIView.addToViewByConstraints(parent: view,
                subView: rePasswordTxtField,
                top: YAnchor(direction: passwordTxtField.bottomAnchor, constant: 2 * marginSpace),
                bottom: nil,
                leading: XAnchor(direction: view.leadingAnchor, constant: view.bounds.width * 0.05),
                trailing: XAnchor(direction: view.trailingAnchor, constant: -view.bounds.width * 0.05),
                centerY: nil,
                centerX: XAnchor(direction: view.centerXAnchor, constant: 0),
                width: nil,
                height: heightTextField)
        }
        
        rePasswordTxtField.afterEffect(fontSize: heightTextField * 0.4, corner: heightTextField * 0.5)
    }
    
    // Register Button
    func initializeRegisterButton() {
        registerBtn = UIButton("Register", Common.color.blue, .white, backImage: nil)
        guard let registerBtn = registerBtn, let rePasswordTxtField = rePasswordTxtField else {
            return
        }
        
        
        if UIDevice.current.userInterfaceIdiom == .phone {
            UIView.addToViewByConstraints(parent: view,
                subView: registerBtn,
                top: YAnchor(direction: rePasswordTxtField.bottomAnchor, constant: 4 * marginSpace),
                bottom: nil,
                leading: nil,
                trailing: nil,
                centerY: nil,
                centerX: XAnchor(direction: view.centerXAnchor, constant: 0),
                width: width * 0.5,
                height: heightButton)
        }
        else if UIDevice.current.userInterfaceIdiom == .pad {
            UIView.addToViewByConstraints(parent: view,
                subView: registerBtn,
                top: YAnchor(direction: rePasswordTxtField.bottomAnchor, constant: 4 * marginSpace),
                bottom: nil,
                leading: nil,
                trailing: nil,
                centerY: nil,
                centerX: XAnchor(direction: view.centerXAnchor, constant: 0),
                width: width * 0.3,
                height: heightButton)
        }
        

        
        registerBtn.afterEffect(textSize: heightButton * 0.5, corner: heightButton * 0.2)
        
    }
}
