//
//  Image.swift
//  Udemy
//
//  Created by Phúc Lý on 9/29/20.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    static func getSquareImageView(name: String, lengthOfEdge: CGFloat) -> UIImageView {
        let imgView = UIImageView(image: UIImage(named: name))
        
        imgView.frame.size = CGSize(width: lengthOfEdge, height: lengthOfEdge)
        
        return imgView
    }
    
    static func getRectImageView(name: String, width: CGFloat, height: CGFloat) -> UIImageView {
        let imgView = UIImageView(image: UIImage(named: name))
        
        imgView.frame.size = CGSize(width: width, height: height)
        
        return imgView
    }
    
}
