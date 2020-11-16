//
//  JoinedCourse.swift
//  Udemy
//
//  Created by Phúc Lý on 16/11/2020.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import Foundation

struct SimpleCourse: Codable {
    var _id: String?
    var name: String?
    var image: String?
}

struct JoinedCourse: Codable {
    var percentCompleted: Int?
    var created_at: String?
    var _id: String?
    var idUser: String?
    var idCourse: SimpleCourse
    
}
