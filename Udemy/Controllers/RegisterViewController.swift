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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Register"
        view.backgroundColor = .clear
        view.addGradient(colors: [Common.color.blue.cgColor, Common.color.purple.cgColor], start: CGPoint(x: 0.0, y: 0.0), end: CGPoint(x: 0.0, y: 1.0) )
        
        width = view.bounds.width
        height = view.bounds.height
        navBarHeight = navigationController?.navigationBar.bounds.height ?? 44
        
        initializeNameTextField()
        initializeGenderTextField()
        initializePhoneNumberTextField()
        initializeAddressTextField()
        initializeDescriptionTextField()
        initializePasswordTextField()
        initializeRePasswordTextField()
        initializeRegisterButton()
    }
    
    
    @objc func registerBtnPressed(_ sender: UIButton) {
        
    }
}
