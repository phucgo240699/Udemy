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
    convenience init(placeholder: String, keyType: UIKeyboardType, isHideText: Bool = false) {
        self.init(frame: .zero)
        self.placeholder = placeholder
        if #available(iOS 13.0, *) {
            backgroundColor = .systemBackground
        } else {
            // Fallback on earlier versions
            backgroundColor = .white
        }
        returnKeyType = .default
        keyboardType = keyType
        isSecureTextEntry = isHideText
        clearButtonMode = .whileEditing
        borderStyle = .roundedRect
    }
    
    convenience init(text: String, keyType: UIKeyboardType, isHideText: Bool = false) {
        self.init(frame: .zero)
        self.text = text
        if #available(iOS 13.0, *) {
            backgroundColor = .systemBackground
        } else {
            // Fallback on earlier versions
            backgroundColor = .white
        }
        keyboardType = keyType
        isSecureTextEntry = isHideText
        clearButtonMode = .whileEditing
        textAlignment = .natural
        borderStyle = .roundedRect
    }
    
    func afterEffect(fontSize: CGFloat, corner: CGFloat) {
        self.font = UIFont(name: Common.fontName, size: fontSize)
        self.layer.cornerRadius = corner
    }
}
