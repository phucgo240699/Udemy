//
//  RegisterResponse.swift
//  Udemy
//
//  Created by Phúc Lý on 10/6/20.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import Foundation
import UIKit

struct RegisterResponse: Decodable {
    var active: Int?
    var created_at: String?
    var name: String?
    var _id: String?
    var email: String?
    var password: String?
    var phone: String?
    var address: String?
    var description: String?
    var role: String?
    var image: String?
    var gender: String?
}
