//
//  TokenManager.swift
//  Udemy
//
//  Created by Phúc Lý on 9/29/20.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import Foundation

class TokenManager {
    static func getAccessToken() -> String? {
        return UserDefaults.standard.string(forKey: "accessToken")
    }
    
    static func setAccessToken(_ accessToken: String) {
        UserDefaults.standard.setValue(accessToken, forKey: "accessToken")
    }
    
    static func releaseAccessToken() {
        UserDefaults.standard.removeObject(forKey: "accessToken")
    }
}
