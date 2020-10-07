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
    
    var email: String? {
        didSet {
            if let unwrap = email {
                emailTxtField?.text = unwrap
            }
        }
    }
    
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
        
        view.backgroundColor = .clear
        view.addGradient(colors: [Common.color.blue.cgColor, Common.color.purple.cgColor], start: CGPoint(x: 0.0, y: 0.0), end: CGPoint(x: 0.0, y: 1.0) )
        
        initializeCloseButton()
        initializeTextField(&emailTxtField, "Enter email", closeBtn, height * 0.05)
        initializeTextField(&activationTxtField, "Enter activation code", emailTxtField, height * 0.02)
        initializeActivationButton()
    }
    
    @objc func closeBtnPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func activationBtnPressed(_ sender: UIButton) {
        guard let email = email, let activeToken = TokenManager.getToken() else {
            return
        }
        
        active(url: Common.link.activeAccount, email: email, activeToken: activeToken)
    }
}
