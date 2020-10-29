//
//  TextView.swift
//  Udemy
//
//  Created by Phúc Lý on 9/29/20.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import UIKit

extension UITextView {
    
    convenience init(_ placeholder: String) {
        self.init(frame: .zero)
        text = placeholder
        backgroundColor = Common.color.backgroundColor
        textColor = Common.color.placeholderColor
    }
    
    func afterEffect(fontSize: CGFloat, corner: CGFloat) {
        self.font = UIFont(name: Common.fontName, size: fontSize)
        self.layer.cornerRadius = corner
    }
}
