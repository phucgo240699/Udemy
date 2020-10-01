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
    
    var width:CGFloat = 0
    var height: CGFloat = 0
    var navBarHeight: CGFloat = 0
    var heightTextField: CGFloat = 0
    var heightButton: CGFloat = 0
    var marginSpace: CGFloat = UIDevice.current.userInterfaceIdiom == .pad ? 20.0: 10.0

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Register"
        view.backgroundColor = .clear
        view.addGradient(colors: [Common.color.blue.cgColor, Common.color.purple.cgColor], start: CGPoint(x: 0.0, y: 0.0), end: CGPoint(x: 0.0, y: 1.0) )
        
        width = view.bounds.width
        height = view.bounds.height
        heightTextField = UIDevice.current.userInterfaceIdiom == .phone ? width * 0.1 : width * 0.08
        heightButton = UIDevice.current.userInterfaceIdiom == .phone ? width * 0.1 : width * 0.08
        navBarHeight = navigationController?.navigationBar.bounds.height ?? 44
        
        initializeCloseButton()
        initializeNameTextField()
        initializeGenderTextField()
        initializePhoneNumberTextField()
        initializeAddressTextField()
        initializeDescriptionTextField()
        initializePasswordTextField()
        initializeRePasswordTextField()
        initializeRegisterButton()
        
        nameTxtField?.delegate = self
        genderTxtField?.delegate = self
        phoneNumbersTxtField?.delegate = self
        addressTxtField?.delegate = self
        descriptionTxtField?.delegate = self
        passwordTxtField?.delegate = self
        rePasswordTxtField?.delegate = self
    }
    
    @objc func closeBtnPressed(_ sender: UIButton) {
        UIView.animate(withDuration: 0.5,
                       delay: 0.0,
                       options: [.transitionFlipFromBottom ],
                       animations: {
                        (UIApplication.shared.delegate as! AppDelegate).window?.setController(.login)
        }, completion: nil)
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
