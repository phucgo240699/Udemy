//
//  LoginResponse.swift
//  Udemy
//
//  Created by Phúc Lý on 10/6/20.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import UIKit

struct LoginResponse: Decodable {
    var _id: String?
    var email: String?
    var password: String?
    var name: String?
    var phone: String?
    var role: String?
    var image: String?
    var gender: String?
    var created_at: String?
    var active: Int?
    var activeToken: String?
}
