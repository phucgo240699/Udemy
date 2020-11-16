//
//  IsJoinedCourse.swift
//  Udemy
//
//  Created by Phúc Lý on 17/11/2020.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import Foundation

struct IsJoinedCourse: Codable {
    var isJoined: Bool?
    
    enum CodingKeys: String, CodingKey {
        case isJoined = "is-joined"
    }
}
