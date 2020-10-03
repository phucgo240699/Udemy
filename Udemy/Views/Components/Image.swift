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
    convenience init(name: String, lengthOfEdge: CGFloat){
        self.init(frame: .zero)
        image = UIImage(named: name)
        frame.size = CGSize(width: lengthOfEdge, height: lengthOfEdge)
    }
    
    convenience init(name: String, width: CGFloat, height: CGFloat) {
        self.init(frame: .zero)
        image = UIImage(named: name)
        frame.size = CGSize(width: width, height: height)
    }
    
}
