//
//  Common.swift
//  Udemy
//
//  Created by Phúc Lý on 9/29/20.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import Foundation
import UIKit

struct ImageName {
    var logo: String = "planet"
    var xmark_circle = "xmark_circle"
    var done = "done-icon"
}

struct CustomColor {
    var snow: UIColor = UIColor(red: 252/255, green: 247/255, blue: 248/255, alpha: 1.0)
    var lightGray: UIColor = UIColor(red: 206/255, green: 211/255, blue: 220/255, alpha: 1.0)
    var lightRed: UIColor = UIColor(red: 234/255, green: 55/255, blue: 45/255, alpha: 0.7)
    var blue: UIColor = UIColor(red: 39/255, green: 93/255, blue: 173/255, alpha: 1.0)
    var purple: UIColor = UIColor(red: 106/255, green: 15/255, blue: 161/255, alpha: 1.0)
    var quickSilver: UIColor = UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 1.0)
}

struct Link {
    let register: String = "http://149.28.24.98:9000/register"
    let activeAccount: String = "http://149.28.24.98:9000/active-account"
    let login: String = "http://149.28.24.98:9000/login"
    
}

class Common {
    static var imageName: ImageName = ImageName()
    static var color: CustomColor = CustomColor()
    static var fontName: String = "Futura"
    static var link: Link = Link()
}
