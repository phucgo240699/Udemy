//
//  String.swift
//  Udemy
//
//  Created by Phúc Lý on 10/6/20.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import Foundation

extension String {
    func isEmptyOrSpacing() -> Bool {
        if self.isEmpty == true {
            return true
        }
        
        for e in self {
            if e != " " {
                return false
            }
        }
        
        return true
    }
}
