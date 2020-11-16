//
//  JoinCourse.swift
//  Udemy
//
//  Created by Phúc Lý on 16/11/2020.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD

extension CourseDetailVC {
    func joinCourse(idUser: String?, idCourse: String?) {
        guard let appDelegate = (UIApplication.shared.delegate as? AppDelegate) else {
            return
        }
        guard let window = appDelegate.window else {
            return
        }
        
        // Params
        guard let idUser = idUser, let idCourse = idCourse else {
            window.showError("Join failed", "Not enough information")
            return
        }
        let params: [String: Any] = ["idUser": idUser, "idCourse": idCourse]
        
        // URL
        let rawUrl = URL(string: "\(Common.link.joinCourse)")
        guard let url = rawUrl else {
            return
        }
        
        // show waiting progress
        SVProgressHUD.show()
        
        // Call API
        AF.request(url, method: .put, parameters: params, encoding: JSONEncoding.default, headers: nil).response{
            response in
            
            // off waiting progress
            SVProgressHUD.dismiss()
            
            if let error = response.error?.errorDescription {
                window.showError("Error", String(error.description.split(separator: ":")[1]))
                return
            }
            guard let statusCode = response.response?.statusCode else {
                return
            }
            
            guard let data = response.data else {
                return
            }
            
            if statusCode == 200 {
                self.isJoinedCourse = true
                window.notificate(UIImage(named: Common.imageName.done), "Joined Successfully", "")
            }
            else {
                self.parseErrorJSON(from: data)
            }
        }
    }
    
    func parseErrorJSON(from data: Data) {
        guard let appDelegate = (UIApplication.shared.delegate as? AppDelegate) else {
            return
        }
        guard let window = appDelegate.window else {
            return
        }
        
        do {
            let errorMessageResponse = try JSONDecoder().decode(ErrorMessageResponse.self, from: data)
            window.showError("Join failed", errorMessageResponse.message ?? "There is an error")
        } catch {
            window.showError("Join failed", error.localizedDescription)
        }
    }
}
