//
//  CourseRating.swift
//  Udemy
//
//  Created by Phúc Lý on 21/11/2020.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import Foundation

struct CourseRating: Codable {
    var create_at: String?
    var image: String?
    var _id: String?
    var idUser: UserCourse?
    var numStar: Int?
    var idCourse: String?
    var content: String?
}
