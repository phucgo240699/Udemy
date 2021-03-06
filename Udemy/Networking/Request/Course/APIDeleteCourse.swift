//
//  APIDeleteCourse.swift
//  Udemy
//
//  Created by Phúc Lý on 28/12/2020.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import Alamofire
import SVProgressHUD

extension RequestAPI {
    func deleteCourse(by id: String?, onSuccess: @escaping () -> Void) {
        guard let appDelegate = (UIApplication.shared.delegate as? AppDelegate) else {
            return
        }
        guard let window = appDelegate.window else {
            return
        }
        guard let id = id else {
            return
        }
        
        // URL
        guard let url = URL(string: "\(Common.link.deleteCourse)/\(id)") else {
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
        
        SVProgressHUD.show()
        
        // Call API
        AF.request(url, method: .delete, parameters: nil, encoding: JSONEncoding.default, headers: headers).response{
            response in
            
            // off waiting progress
            SVProgressHUD.dismiss()
            
            if let error = response.error?.errorDescription {
                window.showError("Error", String(error.description.split(separator: ":")[1]) )
                return
            }
            
            guard let data = response.data,
                  let statusCode = response.response?.statusCode else {
                return
            }
            
            if statusCode == 200 {
                onSuccess()
            }
            else {
                self.parseMessageErrorJSON(from: data)
            }
        }
        
    }
    
    
    
    func parseDeleteCourseJSON(_ data: Data, onSuccess: @escaping () -> Void) {
        guard let appDelegate = (UIApplication.shared.delegate as? AppDelegate) else {
            return
        }
        guard let window = appDelegate.window else {
            return
        }
        
        do {
            let result = try JSONDecoder().decode(DeleteLessonResponse.self, from: data)
            
            if result.isSuccess() {
                onSuccess()
            }
            
        } catch {
            window.showError("Pay course failed", error.localizedDescription)
        }
    }
}
