//
//  Account.swift
//  Udemy
//
//  Created by Phúc Lý on 10/7/20.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import Foundation
class Account {
    var email: String?
    var password: String?
    
    init() {
        self.email = UserDefaults.standard.string(forKey: "email")
        self.password = UserDefaults.standard.string(forKey: "password")
    }
    
    func save(_ email: String, _ password: String) {
        self.email = email
        self.password = password
        UserDefaults.standard.setValue(self.email, forKey: "email")
        UserDefaults.standard.setValue(self.password, forKey: "password")
    }
}
