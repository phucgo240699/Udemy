//
//  CourseDetail.swift
//  Udemy
//
//  Created by Phúc Lý on 15/11/2020.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import Foundation

struct CourseDetail: Codable {
    var _id: String?
    var name: String?
    var imageName: String?
    var goal: String?
    var discountPercent: Int?
    var originalPrice: Int?
    var ranking: Int?
    var description: String?
    var idUser: String?
    
    enum CodingKeys: String, CodingKey {
        case _id = "_id"
        case name = "name"
        case goal = "goal"
        case imageName = "image"
        case discountPercent = "discount"
        case originalPrice = "price"
        case ranking = "ranking"
        case description = "description"
        case idUser = "idUser"
    }
    
    var discountPrice: Int? {
        get {
            let restPercent: Double = 1.0 - (Double(discountPercent ?? 0) / 100.0)
            return Int(Double(originalPrice ?? 0) * restPercent)
        }
    }
}
