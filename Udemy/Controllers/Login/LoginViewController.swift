//
//  ViewController.swift
//  Udemy
//
//  Created by Phúc Lý on 9/28/20.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

// MARK: - Summary:
// loginBtnPressed: Call API
// registerBtnPressed: push RegisterViewController

import UIKit


class LoginViewController: UIViewController {
    
    var imageView: UIImageView?
    var emailTxtField: UITextField?
    var passwordTxtField: UITextField?
    var loginBtn: UIButton?
    var registerBtn: UIButton?
    var activeBtn: UIButton?
    var forgotPasswordBtn: UIButton?
    
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
            return navigationController?.navigationBar.bounds.height ?? 44
        }
    }
    var heightTextField: CGFloat {
        get {
            return 44.0
        }
    }
    var heightLoginButton: CGFloat {
        get {
            return 60.0
        }
    }
    var widthLoginButton: CGFloat {
        get {
            return 180.0
        }
    }
    var marginSpace: CGFloat = UIDevice.current.userInterfaceIdiom == .pad ? 20.0: 10.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Setup view
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .clear
        view.addGradient(colors: [Common.color.blue.cgColor, Common.color.purple.cgColor], start: CGPoint(x: 0.0, y: 0.0), end: CGPoint(x: 0.0, y: 1.0) )
        
        // Setup components
        initializeImageView()
        
        guard let imageView = imageView else {
            return
        }
        
        initializeTextField(&emailTxtField, "Email", YAnchor(direction: imageView.bottomAnchor , constant: 2 * marginSpace), keyType: .emailAddress)
        initializeTextField(&passwordTxtField, "Password", YAnchor(direction: emailTxtField!.bottomAnchor, constant: marginSpace), isHideText: true)
        initializeLoginButton()
        initializeRegisterButton()
        initializeForgotPassBtn()
        initializeActiveButton()
        
        emailTxtField?.delegate = self
        passwordTxtField?.delegate = self
        
        // Auto login
        autoLogin()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = true
    }
    
    @objc func loginBtnPressed(_ sender: UIButton) {
        // TODO - Call API Login
        
        login(url: Common.link.login, email: emailTxtField?.text, password: passwordTxtField?.text)
    }
    
    @objc func activeBtnPressed(_ sender: UIButton) {
        navigationController?.pushViewController(ActivationViewController(), animated: true)
    }
    
    @objc func registerBtnPressed(_ sender: UIButton) {
        navigationController?.pushViewController(RegisterViewController(), animated: true)
    }
    
    @objc func forgotPasswordBtnPressed(_ sender: UIButton) {
        navigationController?.pushViewController(GetTokenResetPassVC(), animated: true)
    }
}

// MARK: - Text Field Delegate

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}

