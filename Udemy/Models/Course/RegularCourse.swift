//
//  SimpleCourse.swift
//  Udemy
//
//  Created by Phúc Lý on 18/11/2020.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import Foundation

struct RegularCourse: Codable {
    var vote: Vote?
    var discount: Int?
    var ranking: Int?
    var created_at: String?
    var is_checked: Int?
    var is_required: Bool?
    var _id: String?
    var name: String?
    var idUser: String?
    var image: String?
    var goal: String?
    var description: String?
    var category: String?
    var price: Int?
    
    var discountPrice: Int? {
        get {
            let restPercent: Double = 1.0 - (Double(discount ?? 0) / 100.0)
            return Int(Double(price ?? 0) * restPercent)
        }
    }
    
    func getCourse() -> Course {
        return Course(vote: vote, discount: discount, ranking: ranking, created_at: created_at, is_checked: is_checked, is_required: is_required, _id: _id, name: name, idUser: UserCourse(_id: idUser, name: nil), image: image, goal: goal, description: description, category: Category(_id: category, name: nil, image: nil), price: price)
    }
}
