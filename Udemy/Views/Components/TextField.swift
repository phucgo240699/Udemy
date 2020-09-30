//
//  TextField.swift
//  Udemy
//
//  Created by Phúc Lý on 9/29/20.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import Foundation
import UIKit


extension UITextField {
    static func getInput(placeholder: String, isHideText: Bool = false) -> UITextField {
        let textField = UITextField()
        textField.placeholder = placeholder
        textField.textAlignment = .natural
        textField.tintColor = .systemGray
        textField.backgroundColor = .systemBackground
        textField.textColor = .black
        textField.isSecureTextEntry = isHideText
        textField.clearButtonMode = .whileEditing
        return textField
    }
    
    func afterEffect(fontSize: CGFloat, corner: CGFloat) {
        self.font = UIFont(name: Common.fontName, size: fontSize)
        self.layer.cornerRadius = corner
    }
}
