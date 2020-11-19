//
//  UIImageView+Ex.swift
//  Udemy
//
//  Created by Phúc Lý on 19/11/2020.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import UIKit

extension UIImageView {
    func addBlur() {
        let blur = UIBlurEffect(style: .light)
        let blurView = UIVisualEffectView(effect: blur)
        blurView.frame = self.bounds
        blurView.layer.cornerRadius = self.layer.cornerRadius
        self.addSubview(blurView)
    }
}
