//
//  Date+Ex.swift
//  Udemy
//
//  Created by Phúc Lý on 21/11/2020.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import Foundation

extension Date {
    func toString() -> String {
        let dateFormatter = DateFormatter()
        return dateFormatter.string(from: self)
    }
}
