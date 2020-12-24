//
//  Common.swift
//  Udemy
//
//  Created by Phúc Lý on 9/29/20.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import Foundation
import UIKit

fileprivate let baseUrl: String = "http://149.28.24.98:9000"

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
    var stripe_logo = "stripelogo"
    var lesson = "lesson"
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
    let getImage: String = "\(baseUrl)/upload"
    
    // Auth
    let register: String = "\(baseUrl)/register"
    let activeAccount: String = "\(baseUrl)/active-account"
    let login: String = "\(baseUrl)/login"
    let logout: String = "\(baseUrl)/logout"
    let getTokenResetPass = "\(baseUrl)/forgot-password"
    let resetPass = "\(baseUrl)/reset-password"
    
    let changeProfile: String = "\(baseUrl)/change-profile"
    let changePassword: String = "\(baseUrl)/change-password"
    let changeAvatar: String = "\(baseUrl)/change-avatar"
    let getAvatar: String = "\(baseUrl)/upload/user_image"
    
    
    // Category
    let getAllCategories: String = "\(baseUrl)/category/get-all-category"
    let getCategoryThumbnail: String = "\(baseUrl)/upload/category"
    
    //-- Course
    let getNewCourses: String = "\(baseUrl)/course/get-all"
    let getFreeCourses: String = "\(baseUrl)/course/get-free"
    let getTopCourses: String = "\(baseUrl)/course/get-top"
    let getCourseThumbnail: String = "\(baseUrl)/upload/course_image"
    let getCourseById: String = "\(baseUrl)/course/getbyid"
    let getCoursesByCategory: String = "\(baseUrl)/course/getby-category"
    let joinCourse: String = "\(baseUrl)/join/create-join"
    let checkJoinedCourse: String = "\(baseUrl)/join/check-is-join-course"
    
    let getJoinedCoursesByUser: String = "\(baseUrl)/join/get-courses-joined-by-user"
    
    
    //-- Lesson
    let getLessonsByIdCourse: String = "\(baseUrl)/lesson/get-lesson-by-id-course"
    let getLessonById: String = "\(baseUrl)/lesson/get-lesson-by-id"
    
    
    //-- Rating
    let getRatingsByCourse: String = "\(baseUrl)/rate/get-rate-by-course"
    let sendRating: String = "\(baseUrl)/rate/create-rate"
    
    
    //-- Order
    let getOrderedCourses: String = "\(baseUrl)/order/get-list-course-ordered-by-id-user"
    
    
    //-- Payment
    let getPaymentKey: String = "\(baseUrl)/payment/get-payment-public-key"
    let payCourse: String = "\(baseUrl)/payment/pay"
    
    //-- Search
    let searchCoursesByTitle: String = "\(baseUrl)/course/search-course"
    
    
    //-- Lesson
    let streamingVideo: String = "\(baseUrl)/lesson/stream-video"
}

class Common {
    static var imageName: ImageName = ImageName()
    static var color: CustomColor = CustomColor()
    static var fontName: String = "Futura"
    static var link: Link = Link()
}
