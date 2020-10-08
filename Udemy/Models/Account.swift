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
    var name: String?
    var phone: String?
    var gender: String?
    var role: String?
    var image: String?
    
    init() {
        self.email = UserDefaults.standard.string(forKey: "email")
        self.password = UserDefaults.standard.string(forKey: "password")
        self.name = UserDefaults.standard.string(forKey: "name")
        self.phone = UserDefaults.standard.string(forKey: "phone")
        self.gender = UserDefaults.standard.string(forKey: "gender")
        self.role = UserDefaults.standard.string(forKey: "role")
        self.image = UserDefaults.standard.string(forKey: "image")
    }
    
    func save(_ email: String, _ password: String, _ name: String?, _ phone: String?, _ gender: String?, _ role: String?, _ image: String?) {
        self.email = email
        self.password = password
        self.name = name
        self.phone = phone
        self.gender = gender
        self.role = role
        self.image = image
        UserDefaults.standard.setValue(self.email, forKey: "name")
        UserDefaults.standard.setValue(self.email, forKey: "password")
        UserDefaults.standard.setValue(self.email, forKey: "name")
        UserDefaults.standard.setValue(self.email, forKey: "phone")
        UserDefaults.standard.setValue(self.email, forKey: "gender")
        UserDefaults.standard.setValue(self.email, forKey: "role")
        UserDefaults.standard.setValue(self.password, forKey: "image")
    }
    
    func release() {
        UserDefaults.standard.removeObject(forKey: "email")
        UserDefaults.standard.removeObject(forKey: "password")
        UserDefaults.standard.removeObject(forKey: "name")
        UserDefaults.standard.removeObject(forKey: "phone")
        UserDefaults.standard.removeObject(forKey: "gender")
        UserDefaults.standard.removeObject(forKey: "role")
        UserDefaults.standard.removeObject(forKey: "image")
        self.email = nil
        self.password = nil
        self.name = nil
        self.phone = nil
        self.gender = nil
        self.role = nil
        self.image = nil
        
    }
}
