//
//  ForgotPasswordViewController.swift
//  Udemy
//
//  Created by Phúc Lý on 12/12/2020.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import UIKit
import SVProgressHUD

class ForgotPasswordViewController: UIViewController {

    @IBOutlet weak var newPasswordTf: UITextField!
    @IBOutlet weak var reNewPasswordTf: UITextField!
    @IBOutlet weak var tokenTf: UITextField!
    @IBOutlet weak var resetBtn: UIButton!
    
    var email: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.enableTapToDismiss()
        
        setupUI()
    }

    func setupUI() {
        
        // Setup view
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .clear
        view.insertGradient(index: 0 ,colors: [Common.color.blue.cgColor, Common.color.purple.cgColor], start: CGPoint(x: 0.0, y: 0.0), end: CGPoint(x: 0.0, y: 1.0) )
        
        // TextField
        newPasswordTf.delegate = self
        reNewPasswordTf.delegate = self
        tokenTf.delegate = self
        
        // Button
        resetBtn.afterEffect(cornerRadius: 10, borderWidth: 0, borderColor: .clear)
    }
        
    @IBAction func resetBtnPressed(_ sender: UIButton) {
        SVProgressHUD.show()
        
        RequestAPI.shared.resetPassword(email, reNewPasswordTf.text, tokenTf.text) {
            
            SVProgressHUD.dismiss()
            
            guard let appDelegate = (UIApplication.shared.delegate as? AppDelegate) else {
                return
            }
            guard let window = appDelegate.window else {
                return
            }
            
            window.notificate(UIImage(named: Common.imageName.done), "Reset password successful", "You can log in now")
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    @IBAction func popBtnPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
}

// MARK: - TextField delegate
extension ForgotPasswordViewController: UITextFieldDelegate{
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if let firstCount = newPasswordTf.text?.count, let secondCount = reNewPasswordTf.text?.count, let thirdCount = tokenTf.text?.count {
            if firstCount > 0 && secondCount > 0 && thirdCount > 0 && newPasswordTf.text == reNewPasswordTf.text {
                
                resetBtn.isEnabled = true
                resetBtn.backgroundColor = Common.color.blue
                
            }
        }
        else {
            resetBtn.isEnabled = false
            resetBtn.backgroundColor = .lightGray
        }
    }
}
