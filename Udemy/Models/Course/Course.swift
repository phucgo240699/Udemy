//
//  Course.swift
//  Udemy
//
//  Created by Phúc Lý on 10/6/20.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import Foundation

struct UserCourse: Codable {
    var _id: String?
    var name: String?
    var image: String?
}

struct Course: Codable {
    var vote: Vote?
    var discount: Int?
    var ranking: Int?
    var created_at: String?
    var is_checked: Int?
    var is_required: Bool?
    var _id: String?
    var name: String?
    var idUser: UserCourse?
    var image: String?
    var goal: String?
    var description: String?
    var category: Category?
    var price: Int?
    
    var discountPrice: Int? {
        get {
            let restPercent: Double = 1.0 - (Double(discount ?? 0) / 100.0)
            return Int(Double(price ?? 0) * restPercent)
        }
    }
    
    func getRegularCourse() -> RegularCourse {
        return RegularCourse(vote: vote, discount: discount, ranking: ranking, created_at: created_at, is_checked: is_checked, is_required: is_required, _id: _id, name: name, idUser: idUser?._id, image: image, goal: goal, description: description, category: category?._id, price: price)
    }
}
