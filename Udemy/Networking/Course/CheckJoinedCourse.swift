//
//  CheckJoinedCourse.swift
//  Udemy
//
//  Created by Phúc Lý on 16/11/2020.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD

extension CourseDetailVC {
    func checkJoinedCourse(idUser: String?, idCourse: String?) {
        guard let appDelegate = (UIApplication.shared.delegate as? AppDelegate) else {
            return
        }
        guard let window = appDelegate.window else {
            return
        }
        
        // Params
        guard let idUser = idUser, let idCourse = idCourse else {
            window.showError("check join failed", "Not enough information")
            return
        }
        
        // URL
        let rawUrl = URL(string: "\(Common.link.checkJoinedCourse)/\(idUser)/\(idCourse)")
        guard let url = rawUrl else {
            return
        }
        
        // Call API
        AF.request(url, method: .put, parameters: nil, encoding: JSONEncoding.default, headers: nil).response{
            response in
            
            if let error = response.error?.errorDescription {
                window.showError("Error", String(error.description.split(separator: ":")[1]))
                return
            }
            guard let statusCode = response.response?.statusCode else {
                return
            }
            
            if statusCode == 200 {
                self.isJoinedCourse = true
            }
        }
    }
}
