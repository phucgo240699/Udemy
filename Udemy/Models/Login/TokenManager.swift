//
//  TokenManager.swift
//  Udemy
//
//  Created by Phúc Lý on 9/29/20.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import Foundation

class TokenManager {
    static func getToken() -> String? {
        return UserDefaults.standard.string(forKey: "accessToken")
    }
    
    static func setToken(_ accessToken: String) {
        UserDefaults.standard.setValue(accessToken, forKey: "accessToken")
    }
}
