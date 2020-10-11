//
//  InformationViewController.swift
//  Udemy
//
//  Created by Phúc Lý on 10/11/20.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import UIKit

class InformationViewController: UIViewController {
    
    var emailTxtField: UITextField?
    var passwordTxtField: UITextField?
    var nameTxtField: UITextField?
    var phoneTxtField: UITextField?
    var genderTxtField: UITextField?
    var roleTxtField: UITextField?
    var imageTxtField: UITextField?
    
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
        title = "Information"
        
        // Background
        view.backgroundColor = Common.color.wildBlueYonder
        
        // Components
        initializeTextField(&emailTxtField, account?.email, view.topAnchor, navBarHeight * 2.2, keyType: .emailAddress)
        initializeTextField(&passwordTxtField, account?.password, emailTxtField?.bottomAnchor, marginSpace, isHideText: true)
        initializeTextField(&nameTxtField, account?.name, passwordTxtField?.bottomAnchor, marginSpace)
        initializeTextField(&phoneTxtField, account?.phone, nameTxtField?.bottomAnchor, marginSpace, keyType: .numberPad)
        initializeTextField(&genderTxtField, account?.gender, phoneTxtField?.bottomAnchor, marginSpace)
        initializeTextField(&roleTxtField, account?.role, genderTxtField?.bottomAnchor, marginSpace)
        initializeTextField(&imageTxtField, account?.image, roleTxtField?.bottomAnchor, marginSpace)
        
        initializeUpdateButton()
        
        // Dis editting some fields
        genderTxtField?.isEnabled = false
        roleTxtField?.isEnabled = false
        imageTxtField?.isEnabled = false
        
    }
}


// MARK: - Text Field Delegate
extension InformationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}
