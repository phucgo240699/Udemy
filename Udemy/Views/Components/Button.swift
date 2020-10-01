//
//  Button.swift
//  Udemy
//
//  Created by Phúc Lý on 9/29/20.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    static func getButton(_ title: String, _ backColor: UIColor?, _ textColor: UIColor?) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(textColor, for: .normal)
        button.backgroundColor = backColor == nil ? .none : backColor!
        return button
    }
    
    static func getBackButton() -> UIButton {
        let back = UIButton()
        back.setBackgroundImage(UIImage(systemName: "arrow.left"), for: .normal)
        return back
    }
    
    func afterEffect(textSize: CGFloat, corner: CGFloat) {
        self.titleLabel?.font = UIFont(name: Common.fontName, size: textSize)
        self.layer.cornerRadius = corner
    }
}
