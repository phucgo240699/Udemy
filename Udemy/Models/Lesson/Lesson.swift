//
//  LessonResponse.swift
//  Udemy
//
//  Created by Phúc Lý on 17/12/2020.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import Foundation

struct LessonQuestion: Codable {
    var _id: String?
    var question: String?
    var A: String?
    var B: String?
    var C: String?
    var D: String?
    var image: String?
    var timeShow: Int?
    var answer: String?
    
    func getAnswerIndex() -> Int {
        switch self.answer {
        case "A":
            return 0
        case "B":
            return 1
        case "C":
            return 2
        default:
            return 3
        }
    }
}

struct Lesson: Codable {
    var _id: String?
    var doc: [String]?
    var multipleChoices: [LessonQuestion]?
    var popupQuestion: [LessonQuestion]?
    var video: String?
    var idCourse: String?
    var title: String?
    var order: Int?
}
