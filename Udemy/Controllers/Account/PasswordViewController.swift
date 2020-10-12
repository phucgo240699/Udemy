//
//  PasswordViewController.swift
//  Udemy
//
//  Created by Phúc Lý on 10/12/20.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import UIKit

class PasswordViewController: UIViewController {

    var oldPasswordTxtField: UITextField?
    var newPasswordTxtField: UITextField?
    var updateBtn: UIButton?
    
    
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
            return width * (UIDevice.current.userInterfaceIdiom == .phone ? 0.12 : 0.08)
        }
    }
    var heightUpdateButton: CGFloat {
        get {
            return width * (UIDevice.current.userInterfaceIdiom == .phone ? 0.12 : 0.08)
        }
    }
    var widthUpdateButton: CGFloat {
        get {
            return width * (UIDevice.current.userInterfaceIdiom == .phone ? 0.4 : 0.3)
        }
    }
    var marginSpace: CGFloat = UIDevice.current.userInterfaceIdiom == .pad ? 20.0: 10.0
    var account: Account? {
        get {
            guard let appDelegate = (UIApplication.shared.delegate as? AppDelegate) else {
                return nil
            }
            return appDelegate.account
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Title
        title = "Password"
        
        // Background
        view.backgroundColor = .clear
        view.addGradient(colors: [Common.color.blue.cgColor, Common.color.purple.cgColor], start: CGPoint(x: 0.0, y: 0.0), end: CGPoint(x: 0.0, y: 1.0) )

        // Components
        initializeTextField(&oldPasswordTxtField, account?.password, "Old password", view.topAnchor, navBarHeight * 2.5)
        initializeTextField(&newPasswordTxtField, nil, "New password", oldPasswordTxtField?.bottomAnchor, marginSpace)
        
        initializeBottomButton(&updateBtn, "Update", newPasswordTxtField?.bottomAnchor, 4 * marginSpace)
    }
    
    @objc func updateBtnPressed(_ sender: UIButton) {
        updatePassword(Common.link.changePassword, oldPasswordTxtField?.text, newPasswordTxtField?.text)
    }
}

// MARK: - Text Field Delegate
extension PasswordViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}
