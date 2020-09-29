//
//  View.swift
//  Udemy
//
//  Created by Phúc Lý on 9/29/20.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    static func addToViewByConstraints(parent: UIView, subView: UIView, top: YAnchor?, bottom: YAnchor?, leading: XAnchor?, trailing: XAnchor?, centerY: YAnchor?, centerX: XAnchor?, width: CGFloat?, height: CGFloat? ) {
        
        subView.translatesAutoresizingMaskIntoConstraints = false
        parent.addSubview(subView)
        
        if let width = width {
            subView.widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        if let height = height {
            subView.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        if let leading = leading {
            subView.leadingAnchor.constraint(equalTo: leading.direction, constant: leading.constant).isActive = true
        }
        if let trailing = trailing {
            subView.trailingAnchor.constraint(equalTo: trailing.direction, constant: trailing.constant).isActive = true
        }
        if let top = top {
            subView.topAnchor.constraint(equalTo: top.direction, constant: top.constant).isActive = true
        }
        if let bottom = bottom {
            subView.bottomAnchor.constraint(equalTo: bottom.direction, constant: bottom.constant).isActive = true
        }
        if let centerY = centerY {
            subView.centerYAnchor.constraint(equalTo: centerY.direction, constant: centerY.constant).isActive = true
        }
        if let centerX = centerX {
            subView.centerXAnchor.constraint(equalTo: centerX.direction, constant: centerX.constant).isActive = true
        }
    }
    
    func addGradient(colors: [CGColor], start: CGPoint, end: CGPoint) {
        let gradient = CAGradientLayer()
        gradient.frame = self.frame
        gradient.colors = colors 
        gradient.startPoint = start
        gradient.endPoint = end
        gradient.locations = [0.0, 1.0]
        self.layer.addSublayer(gradient)
    }
}
