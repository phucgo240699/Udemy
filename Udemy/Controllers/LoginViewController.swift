//
//  ViewController.swift
//  Udemy
//
//  Created by Phúc Lý on 9/28/20.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    var imageView: UIImageView?
    var emailTxtField: UITextField?
    var passwordTxtField: UITextField?
    var loginBtn: UIButton?
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
        initializeTextField(&emailTxtField, "Email", YAnchor(direction: view.centerYAnchor , constant: 0))
        initializeTextField(&passwordTxtField, "Password", YAnchor(direction: emailTxtField!.bottomAnchor, constant: height * 0.02))
        initializeLoginButton()
        initializeRegisterButton()
        
        emailTxtField?.delegate = self
        passwordTxtField?.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = true
    }
    
    @objc func loginBtnPressed(_ sender: UIButton) {
        // if login success
        UIView.animate(withDuration: 0.5) {
            (UIApplication.shared.delegate as! AppDelegate).window?.setController(.mainTab)
        }
    }
    
    @objc func registerBtnPressed(_ sender: UIButton) {
        self.navigationController?.pushViewController(RegisterViewController(), animated: true)
    }
}

// MARK: - Text Field Delegate

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}

