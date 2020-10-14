//
//  Account.swift
//  Udemy
//
//  Created by Phúc Lý on 10/7/20.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import UIKit
class Account {
    var _id: String?
    var email: String?
    var password: String?
    var name: String?
    var phone: String?
    var gender: String?
    var role: String?
    var imageName: String?
    var address: String?
    var description: String?
    var avatar: UIImage?
    
    init() {
        self.email = UserDefaults.standard.string(forKey: "email")
        self.password = UserDefaults.standard.string(forKey: "password")
    }
    
    func update(_ _id: String?, _ email: String?, _ password: String?, _ name: String?, _ phone: String?, _ gender: String?, _ role: String?, _ imageName: String?, _ address: String?, _ description: String?) {
        self._id = _id
        self.email = email
        self.password = password
        self.name = name
        self.phone = phone
        self.gender = gender
        self.role = role
        self.imageName = imageName
        self.address = address
        self.description = description
    }
    
    func save() {
        UserDefaults.standard.set(self.email, forKey: "email")
        UserDefaults.standard.set(self.password, forKey: "password")
    }
    
    func release() {
        UserDefaults.standard.removeObject(forKey: "email")
        UserDefaults.standard.removeObject(forKey: "password")
        self._id = nil
        self.email = nil
        self.password = nil
        self.name = nil
        self.phone = nil
        self.gender = nil
        self.role = nil
        self.imageName = nil
        self.address = nil
        self.description = nil
        
    }
}
