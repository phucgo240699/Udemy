//
//  UpdateCourseResponse.swift
//  Udemy
//
//  Created by Phúc Lý on 28/12/2020.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import Foundation

struct UpdateCourseResponse: Codable {
    var status: String?
    var updated: RegularCourse?
}
