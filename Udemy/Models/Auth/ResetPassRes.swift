//
//  ResetPassRes.swift
//  Udemy
//
//  Created by Phúc Lý on 12/12/2020.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import Foundation

struct ResetPassRess: Codable {
    var _id: String?
    var email: String?
    var password: String?
    var name: String?
    var phone: String?
    var address: String?
    var description: String?
    var role: String?
    var imageName: String?
    var gender: String?
    var created_at: String?
    var active: Int?
    var activeToken: String?
    var resetPasswordToken: String?
    
    enum CodingKeys: String, CodingKey {
        case _id = "_id"
        case email = "email"
        case password = "password"
        case name = "name"
        case phone = "phone"
        case address = "address"
        case description = "description"
        case role = "role"
        case imageName = "image"
        case gender = "gender"
        case created_at = "created_at"
        case active = "active"
        case activeToken = "activeToken"
        case resetPasswordToken = "resetPasswordRoken"
    }
}
