//
//  ErrorResponse.swift
//  Udemy
//
//  Created by Phúc Lý on 10/6/20.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import Foundation

struct ErrorMessageResponse: Decodable {
    var message: String?
}

struct ErrorContent: Decodable {
    var value: String?
    var msg: String?
    var param: String?
    var location: String?
}

struct ErrorResponse: Decodable {
    var errors: [ErrorContent]
}
