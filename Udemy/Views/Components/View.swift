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
    func addToViewByConstraints(parent: UIView, top: YAnchor?, bottom: YAnchor?, leading: XAnchor?, trailing: XAnchor?, centerY: YAnchor?, centerX: XAnchor?, width: CGFloat?, height: CGFloat? ) {
        
        if self.isDescendant(of: parent) == false {
            parent.addSubview(self)
        }
            
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if let width = width {
            self.widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        if let height = height {
            self.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        if let leading = leading {
            self.leadingAnchor.constraint(equalTo: leading.direction, constant: leading.constant).isActive = true
        }
        if let trailing = trailing {
            self.trailingAnchor.constraint(equalTo: trailing.direction, constant: trailing.constant).isActive = true
        }
        if let top = top {
            self.topAnchor.constraint(equalTo: top.direction, constant: top.constant).isActive = true
        }
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom.direction, constant: bottom.constant).isActive = true
        }
        if let centerY = centerY {
            self.centerYAnchor.constraint(equalTo: centerY.direction, constant: centerY.constant).isActive = true
        }
        if let centerX = centerX {
            self.centerXAnchor.constraint(equalTo: centerX.direction, constant: centerX.constant).isActive = true
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
    
    func pin(to parentView: UIView) {
        if self.isDescendant(of: parentView) == false {
            parentView.addSubview(self)
        }
        translatesAutoresizingMaskIntoConstraints = false
        
        topAnchor.constraint(equalTo: parentView.topAnchor).isActive = true
        bottomAnchor.constraint(equalTo: parentView.bottomAnchor).isActive = true
        leadingAnchor.constraint(equalTo: parentView.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: parentView.trailingAnchor).isActive = true
    }
    
    func roundCorners(roundingCorners: UIRectCorner, cornerRadius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: roundingCorners, cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = path.cgPath
        self.layer.mask = maskLayer
    }
}
