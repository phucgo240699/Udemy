//
//  RegisterViewController.swift
//  Udemy
//
//  Created by Phúc Lý on 9/29/20.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import Foundation
import UIKit

class RegisterViewController: UIViewController {
//    let contentTextFields: [String] = ["Name", "Gender", "Phone numbers", "Address", "Description", "Password", "Re-password"]
    var closeBtn: UIButton?
    var nameTxtField: UITextField?
    var genderTxtField: UITextField?
    var phoneNumbersTxtField: UITextField?
    var addressTxtField: UITextField?
    var descriptionTxtField: UITextField?
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

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Register"
        view.backgroundColor = .clear
        view.addGradient(colors: [Common.color.blue.cgColor, Common.color.purple.cgColor], start: CGPoint(x: 0.0, y: 0.0), end: CGPoint(x: 0.0, y: 1.0) )
        
        initializeCloseButton()
        initializeTextField(&nameTxtField, "Name", closeBtn)
        initializeTextField(&genderTxtField, "Gender", nameTxtField)
        initializeTextField(&phoneNumbersTxtField, "Phone number", genderTxtField)
        initializeTextField(&addressTxtField, "Address", phoneNumbersTxtField)
        initializeTextField(&descriptionTxtField, "Description", addressTxtField)
        initializeTextField(&passwordTxtField, "Password", descriptionTxtField)
        initializeTextField(&rePasswordTxtField, "Re-password", passwordTxtField)
        initializeRegisterButton()
    }
    
    @objc func closeBtnPressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func registerBtnPressed(_ sender: UIButton) {
        
    }
}

// MARK: - Text Field Delegate

extension RegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}
