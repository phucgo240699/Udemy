//
//  UserFunc.swift
//  Udemy
//
//  Created by Phúc Lý on 10/11/20.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import Foundation

struct AccountResponse: Codable {
    var _id: String?
    var email: String?
    var password: String?
    var name: String?
    var phone: String?
    var address: String?
    var description: String?
    var role: String?
    var image: String?
    var gender: String?
    var created_at: String?
    var active: Int?
    var activeToken: String?
}

struct UserFunc: Codable {
    var status: String?
    var user: AccountResponse?
}
