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
    var heightLoginButton: CGFloat {
        get {
            return width * (UIDevice.current.userInterfaceIdiom == .phone ? 0.12 : 0.08)
        }
    }
    var widthLoginButton: CGFloat {
        get {
            return width * (UIDevice.current.userInterfaceIdiom == .phone ? 0.4 : 0.3)
        }
    }
    var marginSpace: CGFloat = UIDevice.current.userInterfaceIdiom == .pad ? 20.0: 10.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .clear
        view.addGradient(colors: [Common.color.blue.cgColor, Common.color.purple.cgColor], start: CGPoint(x: 0.0, y: 0.0), end: CGPoint(x: 0.0, y: 1.0) )
        
        initializeImageView()
        initializeTextField(&emailTxtField, "Email", YAnchor(direction: view.centerYAnchor , constant: 0), keyType: .emailAddress)
        initializeTextField(&passwordTxtField, "Password", YAnchor(direction: emailTxtField!.bottomAnchor, constant: height * 0.02), isHideText: true)
        initializeLoginButton()
        initializeRegisterButton()
        initializeActiveButton()
        
        emailTxtField?.delegate = self
        passwordTxtField?.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = true
    }
    
    @objc func loginBtnPressed(_ sender: UIButton) {
        // TODO - Call API Login
        
        // if login success
        guard let appDelegate = (UIApplication.shared.delegate as? AppDelegate) else {
            return
        }
        UIView.animate(withDuration: 0.5) {
            appDelegate.window?.setController(.mainTab)
        }
        // if failed, show error
    }
    
    @objc func activeBtnPressed(_ sender: UIButton) {
        navigationController?.pushViewController(ActivationViewController(), animated: true)
    }
    
    @objc func registerBtnPressed(_ sender: UIButton) {
        navigationController?.pushViewController(RegisterViewController(), animated: true)
    }
}

// MARK: - Text Field Delegate

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}

