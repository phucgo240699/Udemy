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
        if #available(iOS 13.0, *) {
            backgroundColor = .systemBackground
        } else {
            // Fallback on earlier versions
            backgroundColor = .white
        }
        
        if #available(iOS 13.0, *) {
            textColor = .placeholderText
        } else {
            // Fallback on earlier versions
            textColor = .lightGray
        }
    }
    
    func afterEffect(fontSize: CGFloat, corner: CGFloat) {
        self.font = UIFont(name: Common.fontName, size: fontSize)
        self.layer.cornerRadius = corner
    }
}
