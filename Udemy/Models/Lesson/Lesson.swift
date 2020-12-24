//
//  LessonResponse.swift
//  Udemy
//
//  Created by Phúc Lý on 17/12/2020.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import Foundation

struct LessonChoice: Codable {
    var _id: String?
    var question: String?
    var A: String?
    var B: String?
    var C: String?
    var D: String?
    var image: String?
}

struct Lesson: Codable {
    var _id: String?
    var doc: [String]
    var multipleChoices: [LessonChoice]?
    var popupQuestion: [LessonChoice]?
    var video: String?
    var idCourse: String?
    var title: String?
    var order: Int?
}
