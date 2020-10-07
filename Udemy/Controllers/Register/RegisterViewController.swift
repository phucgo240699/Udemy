//
//  RegisterViewController.swift
//  Udemy
//
//  Created by Phúc Lý on 9/29/20.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

// MARK: - Summary:
// registerBtnPressed: Call API register
// closeBarBtnPressed: pop this ViewController

import Foundation
import UIKit
import DropDown

class RegisterViewController: UIViewController {
    //    let contentTextFields: [String] = ["Name", "Gender", "Phone numbers", "Address", "Description", "Password", "Re-password"]
    var closeBtn: UIButton?
    
    var emailTxtField: UITextField?
    var nameTxtField: UITextField?
    var genderBtn: UIButton?
    var genderDropDown: DropDown?
    var phoneNumbersTxtField: UITextField?
    var passwordTxtField: UITextField?
    var rePasswordTxtField: UITextField?
    
    var registerBtn: UIButton?
    
    var width:CGFloat {
        get {
            return self.view.bounds.width
        }
    }
    var height: CGFloat {
        get {
            return self.view.bounds.height
        }
    }
    var navBarHeight: CGFloat {
        get {
            return navigationController?.navigationBar.bounds.height ?? 4
        }
    }
    var heightTextField: CGFloat {
        get {
            return width * (UIDevice.current.userInterfaceIdiom == .phone ? 0.12 : 0.08)
        }
    }
    var heightRegisterButton: CGFloat {
        get {
            return width * (UIDevice.current.userInterfaceIdiom == .phone ? 0.12 : 0.08)
        }
    }
    var widthRegisterButton: CGFloat {
        get {
            return width * (UIDevice.current.userInterfaceIdiom == .phone ? 0.4 : 0.3)
        }
    }
    var marginSpace: CGFloat = UIDevice.current.userInterfaceIdiom == .pad ? 20.0: 10.0
    var isDrop: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .clear
        view.addGradient(colors: [Common.color.blue.cgColor, Common.color.purple.cgColor], start: CGPoint(x: 0.0, y: 0.0), end: CGPoint(x: 0.0, y: 1.0) )
        
        initializeCloseButton()
        initializeTextField(&emailTxtField, "Email", closeBtn, keyType: .emailAddress)
        initializeTextField(&nameTxtField, "Name", emailTxtField)
        initializeBtnField(&genderBtn, "Gender", nameTxtField)
        initializeTextField(&phoneNumbersTxtField, "Phone number", genderBtn, keyType: .numberPad)
        initializeTextField(&passwordTxtField, "Password", phoneNumbersTxtField, isHideText: true)
        initializeTextField(&rePasswordTxtField, "Re-password", passwordTxtField, isHideText: true)
        initializeRegisterButton()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        if isDrop {
            genderDropDown?.hide()
        }
    }
    
    @objc func genderBtnPressed(_ sender: UIButton) {
        genderDropDown = DropDown()
        genderDropDown?.backgroundColor = .systemBackground
        genderDropDown?.textColor = .lightGray
        guard let genderDropDown = genderDropDown else {
            return
        }
        isDrop = true
        genderDropDown.anchorView = sender
        genderDropDown.dataSource =  ["nam", "nu"]
        genderDropDown.bottomOffset = CGPoint(x: 0, y: sender.frame.size.height)
        genderDropDown.show()
        genderDropDown.selectionAction = {(index: Int, item: String) in
            self.genderBtn?.setTitle(item, for: .normal)
            self.isDrop = false
        }
    }
    
    @objc func closeBtnPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func registerBtnPressed(_ sender: UIButton) {
        // Check pass & re-pass must be the same
        guard let pass = passwordTxtField?.text, let rePass = rePasswordTxtField?.text else {
            return
        }
        if pass != rePass {
            guard let appDelegate = UIApplication.shared.delegate else {
                return
            }
            guard let window = appDelegate.window else {
                return
            }
            window?.showError("Problem", "Password and Re-password must be the same")
            return
        }
        
        register(urlString: Common.link.register, email: emailTxtField?.text, password: passwordTxtField?.text, name: nameTxtField?.text, phone: phoneNumbersTxtField?.text, gender: genderBtn?.titleLabel?.text)
    }
}

// MARK: - Text Field Delegate
extension RegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}
