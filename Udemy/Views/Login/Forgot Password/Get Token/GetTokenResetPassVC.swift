//
//  GetTokenResetPassVC.swift
//  Udemy
//
//  Created by Phúc Lý on 12/12/2020.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import UIKit
import SVProgressHUD

class GetTokenResetPassVC: UIViewController {
    
    @IBOutlet weak var emailTf: UITextField!
    @IBOutlet weak var sendBtn: UIButton!
    
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
        emailTf.delegate = self
        emailTf.keyboardType = .emailAddress
        
        // Button
        sendBtn.afterEffect(cornerRadius: 10.0, borderWidth: 0, borderColor: .clear)
    }
    
    @IBAction func sendBtnPressed(_ sender: UIButton) {
        SVProgressHUD.show()
        
        RequestAPI.shared.getTokenResetPass(emailTf.text) { message in
            
            SVProgressHUD.dismiss()
            
            guard let appDelegate = (UIApplication.shared.delegate as? AppDelegate) else {
                return
            }
            guard let window = appDelegate.window, let message = message else {
                return
            }
            
            if message == "đã gửi mail thành công" {
                window.notificate(UIImage(named: Common.imageName.done), message, "")
                
                let forgotPassVC = ForgotPasswordViewController()
                forgotPassVC.email = self.emailTf.text
                
                self.navigationController?.pushViewController(forgotPassVC, animated: true)
            }
        }
    }
    
    @IBAction func popBtnPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
}
// MARK: - TextField delegate
extension GetTokenResetPassVC: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField.text?.count ?? 0 > 0 {
            sendBtn.backgroundColor = Common.color.blue
            sendBtn.isEnabled = true
        }
        else {
            sendBtn.backgroundColor = .lightGray
            sendBtn.isEnabled = false
        }
    }
}
