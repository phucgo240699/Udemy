//
//  File.swift
//  Udemy
//
//  Created by Phúc Lý on 26/12/2020.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import Foundation

struct PayCourseCardRequest: Encodable {
    var id: String?
    var object: String?
}

struct PayCourseTokenRequest: Encodable {
    var name: String?
    var email: String?
    var id: String?
    var object: String?
    var created: Int?
    var type: String?
    var livemode: Bool?
    var used: Bool?
    var card: PayCourseCardRequest?
    
}

struct PayCourseRequest: Encodable {
    var token: PayCourseTokenRequest?
}
