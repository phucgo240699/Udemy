//
//  InformationViewController.swift
//  Udemy
//
//  Created by Phúc Lý on 10/11/20.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import UIKit
import DropDown

class InformationViewController: UIViewController {
    
    var emailTxtField: UITextField?
    var passwordTxtField: UITextField?
    var nameTxtField: UITextField?
    var phoneTxtField: UITextField?
    var genderBtn: UIButton?
    var genderDropDown: DropDown?
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
    var isDrop: Bool = false
    
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
        view.backgroundColor = Common.color.quickSilver
        
        // Components
        initializeTextField(&emailTxtField, account?.email, view.topAnchor, navBarHeight * 2.2, keyType: .emailAddress)
        initializeTextField(&passwordTxtField, account?.password, emailTxtField?.bottomAnchor, marginSpace)
        initializeTextField(&nameTxtField, account?.name, passwordTxtField?.bottomAnchor, marginSpace)
        initializeTextField(&phoneTxtField, account?.phone, nameTxtField?.bottomAnchor, marginSpace, keyType: .numberPad)
        initializeBtnField(&genderBtn, account?.gender, phoneTxtField?.bottomAnchor, marginSpace)
        //        initializeTextField(&genderTxtField, account?.gender, phoneTxtField?.bottomAnchor, marginSpace)
        initializeTextField(&roleTxtField, account?.role, genderBtn?.bottomAnchor, marginSpace)
        initializeTextField(&imageTxtField, account?.image, roleTxtField?.bottomAnchor, marginSpace)
        
        initializeUpdateButton()
        
        // Dis editting some fields
        roleTxtField?.isEnabled = false
        imageTxtField?.isEnabled = false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        if isDrop {
            genderDropDown?.hide()
        }
    }
    
    @objc func genderBtnPressed(_ sender: UIButton) {
        genderDropDown = DropDown()
        genderDropDown?.backgroundColor = .systemBackground
        genderDropDown?.textColor = .lightGray
        guard let genderDropDown = genderDropDown else {
            return
        }
        isDrop = true
        genderDropDown.anchorView = sender
        genderDropDown.dataSource =  ["nam", "nu"]
        genderDropDown.bottomOffset = CGPoint(x: 0, y: sender.frame.size.height)
        genderDropDown.show()
        genderDropDown.selectionAction = {(index: Int, item: String) in
            self.genderBtn?.setTitle(item, for: .normal)
            self.isDrop = false
        }
    }
}


// MARK: - Text Field Delegate
extension InformationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}
