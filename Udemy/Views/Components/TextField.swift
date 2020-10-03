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
    convenience init(placeholder: String, isHideText: Bool = false) {
        self.init(frame: .zero)
        self.placeholder = placeholder
        backgroundColor = .systemBackground
        returnKeyType = .default
        isSecureTextEntry = isHideText
        clearButtonMode = .whileEditing
        borderStyle = .roundedRect
    }
    
    func afterEffect(fontSize: CGFloat, corner: CGFloat) {
        self.font = UIFont(name: Common.fontName, size: fontSize)    }
}
