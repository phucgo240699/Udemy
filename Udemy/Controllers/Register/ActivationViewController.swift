//
//  ActivationViewController.swift
//  Udemy
//
//  Created by Phúc Lý on 10/6/20.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import Foundation
import UIKit

class ActivationViewController: UIViewController {
    
    var closeBtn: UIButton?
    var emailTxtField: UITextField?
    var activationTxtField: UITextField?
    var activationBtn: UIButton?
    
    var email: String?
    
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
        
        // Background
        view.backgroundColor = .clear
        view.addGradient(colors: [Common.color.blue.cgColor, Common.color.purple.cgColor], start: CGPoint(x: 0.0, y: 0.0), end: CGPoint(x: 0.0, y: 1.0) )
        
        // Components
        initializeCloseButton()
        initializeTextField(&emailTxtField, "Enter email", closeBtn, height * 0.05, keyType: .emailAddress)
        initializeTextField(&activationTxtField, "Enter activation code", emailTxtField, height * 0.02)
        
        // take email from register to activation
        emailTxtField?.text = email
        
        initializeActivationButton()
        
        
        // Check email popup
        guard let appDelegate = (UIApplication.shared.delegate as? AppDelegate) else {
            return
        }
        guard let window = appDelegate.window else {
            return
        }
        
        if appDelegate.wasNotifyActivationCode == false {
            appDelegate.wasNotifyActivationCode = true
            window.notificate(UIImage(named: Common.imageName.panda), "Attention", "Check activation code in your email")
        }
    }
    
    @objc func closeBtnPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func activationBtnPressed(_ sender: UIButton) {
        guard let email = emailTxtField?.text, let activeToken = activationTxtField?.text else {
            return
        }
        
        active(url: Common.link.activeAccount, email: email, activeToken: activeToken)
    }
}
