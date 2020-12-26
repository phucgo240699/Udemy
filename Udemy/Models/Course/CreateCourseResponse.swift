//
//  CreateCourseResponse.swift
//  Udemy
//
//  Created by Phúc Lý on 26/12/2020.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import Foundation

struct CreateCourseResponse: Codable {
    var status: String?
    var newCourse: RegularCourse?
    var err: RegularCourse?
    
}
