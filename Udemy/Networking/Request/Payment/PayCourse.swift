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
    func payCourse(name: String?, email: String?, stripeToken: String?, amount: Int?, idCourse: String?, idUser: String?, onSuccess: @escaping () -> Void) {
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
        
        guard let name = name, let email = email, let stripeToken = stripeToken, let amount = amount, let idCourse = idCourse, let idUser = idUser else {
            return
        }
        
        let params: [String: Any] = [
            "name": name,
            "email": email,
            "stripeToken": stripeToken,
            "amount": amount,
            "idCourse": idCourse,
            "idUser": idUser
        ]
        
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
        AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).response{
            response in
            
            // off waiting progress
            SVProgressHUD.dismiss()
            
            if let error = response.error?.errorDescription {
                window.showError("Error", String(error.description.split(separator: ":")[1]) )
                return
            }
            
            guard let data = response.data else {
                return
            }
            
            self.parsePayCourseJSON(data, onSuccess: onSuccess)
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
