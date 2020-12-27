//
//  UpdateLesson.swift
//  Udemy
//
//  Created by Phúc Lý on 27/12/2020.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import Alamofire
import SVProgressHUD

extension RequestAPI {
    func updateLesson(by id: String?, idCourse: String?, order: Int?, title: String?, onSuccess: @escaping (Lesson) -> Void) {
        guard let appDelegate = (UIApplication.shared.delegate as? AppDelegate) else {
            return
        }
        guard let window = appDelegate.window else {
            return
        }
        guard let id = id,
              let title = title,
              let idCourse = idCourse,
              let order = order else {
            return
        }
        
        let params: [String: Any] = [
            "title": title,
            "idCourse": idCourse,
            "order": order
        ]
        // URL
        guard let url = URL(string: "\(Common.link.updateLesson)/\(id)") else {
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
        
        AF.request(url, method: .put, parameters: params, encoding: JSONEncoding.default, headers: headers).response {
            response in
            
            SVProgressHUD.dismiss()
            
            if let error = response.error?.errorDescription {
                window.showError("Error", String(error.description.split(separator: ":")[1]) )
                return
            }
            
            guard let data = response.data else {
                return
            }
            
            guard let statusCode = response.response?.statusCode else {
                return
            }
            
            if statusCode == 200 {
                self.parseUpdateLessonJSON(data, onSuccess: onSuccess)
            }
            else {
                window.showError("Update lesson failed", "")
            }
            
        }
    }
    
    
    func parseUpdateLessonJSON(_ data: Data, onSuccess: @escaping (Lesson) -> Void) {
        guard let appDelegate = (UIApplication.shared.delegate as? AppDelegate) else {
            return
        }
        guard let window = appDelegate.window else {
            return
        }
        
        do {
            let result = try JSONDecoder().decode(Lesson.self, from: data)
            onSuccess(result)
            
        } catch {
            window.showError("Update lessons failed", error.localizedDescription)
        }
    }
}
