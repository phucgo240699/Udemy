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
    
    var width:CGFloat = 0
    var height: CGFloat = 0
    var navBarHeight: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .clear
        view.addGradient(colors: [Common.color.blue.cgColor, Common.color.purple.cgColor], start: CGPoint(x: 0.0, y: 0.0), end: CGPoint(x: 0.0, y: 1.0) )
        
        width = view.bounds.width
        height = view.bounds.height
        navBarHeight = navigationController?.navigationBar.bounds.height ?? 44
        
        initializeImageView()
        initializeInputTextField()
        initializeLoginButton()
        initializeRegisterButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = true
    }
    
    @objc func registerBtnPressed(_ sender: UIButton) {
        UIView.animate(withDuration: 0.5,
                       delay: 0.0,
                       options: [.transitionFlipFromTop],
                       animations: {
                        (UIApplication.shared.delegate as! AppDelegate).window?.setController(.register)
        }, completion: nil)
    }
    

}

