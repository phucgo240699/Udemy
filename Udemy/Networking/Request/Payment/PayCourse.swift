//
//  PayCourse.swift
//  Udemy
//
//  Created by Phúc Lý on 04/12/2020.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import Alamofire
import SVProgressHUD

extension RequestAPI {
    func payCourse(params: PayCourseRequest, onSuccess: @escaping () -> Void) {
        guard let appDelegate = (UIApplication.shared.delegate as? AppDelegate) else {
            return
        }
        guard let window = appDelegate.window else {
            return
        }
        
        // URL
        let rawUrl = URL(string: Common.link.payCourse)
        guard let url = rawUrl else {
            return
        }
        
        
        // Access token
        guard let accessToken = TokenManager.getAccessToken() else {
            return
        }
        
        // Headers
        let headers: HTTPHeaders = [
            "auth-token": accessToken,
            "Accept": "application/json"
        ]
        
        // Call API
        AF.request(url, method: .post, parameters: params, encoder: JSONParameterEncoder.default, headers: headers).response { (response) in
            
            SVProgressHUD.dismiss()
            guard let appDelegate = (UIApplication.shared.delegate as? AppDelegate) else {
                return
            }
            guard let window = appDelegate.window else {
                return
            }
            
            if let error = response.error?.errorDescription {
                window.showError("Error", String(error.description.split(separator: ":")[1]) )
                return
            }
            
            guard let data = response.data,
                  let statusCode = response.response?.statusCode else {
                return
            }
            if statusCode == 200 {
                self.parsePayCourseJSON(data, onSuccess: onSuccess)
            }
            else {
                window.showError("Paid fail", "")
            }
            
        }
    }
    
    func parsePayCourseJSON(_ data: Data, onSuccess: @escaping () -> Void) {
        guard let appDelegate = (UIApplication.shared.delegate as? AppDelegate) else {
            return
        }
        guard let window = appDelegate.window else {
            return
        }
        
        do {
            let result = try JSONDecoder().decode(PayCourseResponse.self, from: data)
            onSuccess()
            
        } catch {
            window.showError("Pay course failed", error.localizedDescription)
        }
    }
}
