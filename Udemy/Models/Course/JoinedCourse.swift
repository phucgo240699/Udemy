//
//  CheckJoinedCourse.swift
//  Udemy
//
//  Created by Phúc Lý on 16/11/2020.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import Foundation

struct JoinedCourse: Codable {
    var isJoined: Bool
    
    enum CodingKeys: String, CodingKey {
        case isJoined = "is-joined"
    }
}
