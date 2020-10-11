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
    var nameTxtField: UITextField?
    var phoneTxtField: UITextField?
    var genderBtn: UIButton?
    var genderDropDown: DropDown?
    var addressTxtField: UITextField?
    var descriptionTxtView: UITextView?
    
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
    var heightTextView: CGFloat {
        get {
            return width * (UIDevice.current.userInterfaceIdiom == .phone ? 0.3 : 0.02)
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
        view.backgroundColor = .clear
        view.addGradient(colors: [Common.color.blue.cgColor, Common.color.purple.cgColor], start: CGPoint(x: 0.0, y: 0.0), end: CGPoint(x: 0.0, y: 1.0) )
        
        // Components
        initializeTextField(&nameTxtField, account?.name, "Name", view.topAnchor, navBarHeight * 2.5)
        initializeTextField(&phoneTxtField, account?.phone, "Phone", nameTxtField?.bottomAnchor, marginSpace, keyType: .numberPad)
        initializeBtnField(&genderBtn, account?.gender, "Gender", phoneTxtField?.bottomAnchor, marginSpace)
        initializeTextField(&addressTxtField, account?.address, "Address", genderBtn?.bottomAnchor, marginSpace)
        initializeTextView(&descriptionTxtView, account?.description, "Description", addressTxtField?.bottomAnchor, marginSpace)
                           
        
        initializeUpdateButton()
        
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
            self.genderBtn?.setTitleColor(Common.color.textColor, for: .normal)
            self.isDrop = false
        }
    }
    
    @objc func updateBtnPressed(_ sender: UIButton) {
        let des = descriptionTxtView?.textColor == UIColor.placeholderText ? "" : descriptionTxtView?.text
        updateAccount(Common.link.changeProfile, nameTxtField?.text, phoneTxtField?.text, addressTxtField?.text, des, genderBtn?.titleLabel?.text)
    }
}


// MARK: - Text Field Delegate
extension InformationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}


