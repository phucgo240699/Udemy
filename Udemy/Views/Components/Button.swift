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
    convenience init(_ title: String?, _ backColor: UIColor?, _ textColor: UIColor?, _ backImage: UIImage?) {
        self.init(frame: .zero)
        setTitle(title, for: .normal)
        setTitleColor(textColor, for: .normal)
        backgroundColor = backColor == nil ? .none : backColor!
        setBackgroundImage(backImage, for: .normal)
    }
    func afterEffect(textSize: CGFloat, corner: CGFloat) {
        self.titleLabel?.font = UIFont(name: Common.fontName, size: textSize)
        self.layer.cornerRadius = corner
    }
}
