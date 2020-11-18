//
//  ViewController+Ex.swift
//  Udemy
//
//  Created by Phúc Lý on 17/11/2020.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import UIKit

extension UIViewController {
    func enableTapToDismiss() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false // Avoid conflict with gesture of tableviewcell
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

}
