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
    var address: String?
    var description: String?
    
    init() {
        self.email = UserDefaults.standard.string(forKey: "email")
        self.password = UserDefaults.standard.string(forKey: "password")
        self.name = UserDefaults.standard.string(forKey: "name")
        self.phone = UserDefaults.standard.string(forKey: "phone")
        self.gender = UserDefaults.standard.string(forKey: "gender")
        self.role = UserDefaults.standard.string(forKey: "role")
        self.image = UserDefaults.standard.string(forKey: "image")
        self.address = UserDefaults.standard.string(forKey: "address")
        self.description = UserDefaults.standard.string(forKey: "description")
    }
    
    func update(_ email: String?, _ password: String?, _ name: String?, _ phone: String?, _ gender: String?, _ role: String?, _ image: String?, _ address: String?, _ description: String?) {
        self.email = email
        self.password = password
        self.name = name
        self.phone = phone
        self.gender = gender
        self.role = role
        self.image = image
        self.address = address
        self.description = description
    }
    
    func save(_ email: String, _ password: String, _ name: String?, _ phone: String?, _ gender: String?, _ role: String?, _ image: String?, _ address: String?, _ description: String?) {
        self.email = email
        self.password = password
        self.name = name
        self.phone = phone
        self.gender = gender
        self.role = role
        self.image = image
        self.address = address
        self.description = description
        UserDefaults.standard.set(self.email, forKey: "email")
        UserDefaults.standard.set(self.password, forKey: "password")
        UserDefaults.standard.set(self.name, forKey: "name")
        UserDefaults.standard.set(self.phone, forKey: "phone")
        UserDefaults.standard.set(self.gender, forKey: "gender")
        UserDefaults.standard.set(self.role, forKey: "role")
        UserDefaults.standard.set(self.image, forKey: "image")
        UserDefaults.standard.set(self.address, forKey: "address")
        UserDefaults.standard.set(self.description, forKey: "description")
    }
    
    func release() {
        UserDefaults.standard.removeObject(forKey: "email")
        UserDefaults.standard.removeObject(forKey: "password")
        UserDefaults.standard.removeObject(forKey: "name")
        UserDefaults.standard.removeObject(forKey: "phone")
        UserDefaults.standard.removeObject(forKey: "gender")
        UserDefaults.standard.removeObject(forKey: "role")
        UserDefaults.standard.removeObject(forKey: "image")
        UserDefaults.standard.removeObject(forKey: "address")
        UserDefaults.standard.removeObject(forKey: "description")
        self.email = nil
        self.password = nil
        self.name = nil
        self.phone = nil
        self.gender = nil
        self.role = nil
        self.image = nil
        self.address = nil
        self.description = nil
        
    }
}
