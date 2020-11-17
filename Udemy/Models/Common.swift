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
    var panda = "panda-icon"
    var star = "star"
    var star_fill = "star.fill"
    var magnifying_glass = "magnifyingglass"
    var square_stack = "square.stack.3d.up"
    var square_stack_fill = "square.stack.3d.up.fill"
    var cart = "cart"
    var cart_fill = "cart.fill"
    var account = "account"
    var account_fill = "account.fill"
    var person = "person"
    var photos = "photos"
    var shield = "shield"
    var credit_card = "credit-card"
    
    
}

struct CustomColor {
    var snow: UIColor = UIColor(red: 252/255, green: 247/255, blue: 248/255, alpha: 1.0)
    var lightGray: UIColor = UIColor(red: 206/255, green: 211/255, blue: 220/255, alpha: 1.0)
    var wildBlueYonder: UIColor = UIColor(red: 171/255, green: 169/255, blue: 195/255, alpha: 1.0)
    var lightRed: UIColor = UIColor(red: 234/255, green: 55/255, blue: 45/255, alpha: 0.7)
    var blue: UIColor = UIColor(red: 39/255, green: 93/255, blue: 173/255, alpha: 1.0)
    var purple: UIColor = UIColor(red: 106/255, green: 15/255, blue: 161/255, alpha: 1.0)
    var silverBackground: UIColor = UIColor(named: "silverBackground") ?? .lightGray
    var backgroundColor: UIColor = UIColor(named: "backgroundColor") ?? .white
    var placeholderColor: UIColor = UIColor(named: "placeholderColor") ?? .lightGray
    var textColor: UIColor = UIColor(named: "textColor") ?? .black
}

struct Link {
    let register: String = "http://149.28.24.98:9000/register"
    let activeAccount: String = "http://149.28.24.98:9000/active-account"
    let login: String = "http://149.28.24.98:9000/login"
    let logout: String = "http://149.28.24.98:9000/logout"
    
    let changeProfile: String = "http://149.28.24.98:9000/change-profile"
    let changePassword: String = "http://149.28.24.98:9000/change-password"
    let changeAvatar: String = "http://149.28.24.98:9000/change-avatar"
    let getAvatar: String = "http://149.28.24.98:9000/upload/user_image"
    
    let getAllCategories: String = "http://149.28.24.98:9000/category/get-all-category"
    let getCategoryThumbnail: String = "http://149.28.24.98:9000/upload/category"
    
    let getNewCourses: String = "http://149.28.24.98:9000/course/get-all"
    let getFreeCourses: String = "http://149.28.24.98:9000/course/get-free"
    let getTopCourses: String = "http://149.28.24.98:9000/course/get-top"
    let getCourseThumbnail: String = "http://149.28.24.98:9000/upload/course_image"
    let getCourseById: String = "http://149.28.24.98:9000/course/getbyid"
    let getCoursesByCategory: String = "http://149.28.24.98:9000/course/getby-category"
    let joinCourse: String = "http://149.28.24.98:9000/join/create-join"
    let checkJoinedCourse: String = "http://149.28.24.98:9000/join/check-is-join-course"
    
    let getJoinedCoursesByUser: String = "http://149.28.24.98:9000/join/get-courses-joined-by-user"
    
    
    //-- Rating
    let sendRating: String = "http://149.28.24.98:9000/rate/create-rate"
}

class Common {
    static var imageName: ImageName = ImageName()
    static var color: CustomColor = CustomColor()
    static var fontName: String = "Futura"
    static var link: Link = Link()
}
