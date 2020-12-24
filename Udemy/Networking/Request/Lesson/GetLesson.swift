//
//  GetLesson.swift
//  Udemy
//
//  Created by Phúc Lý on 17/12/2020.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import Alamofire
import SVProgressHUD


extension RequestAPI {
    func fetchLesson(idLesson: String?, onSuccess: @escaping (Lesson) -> Void) {
        guard let appDelegate = (UIApplication.shared.delegate as? AppDelegate) else {
            return
        }
        guard let window = appDelegate.window else {
            return
        }
        
        // URL
        guard let idLesson = idLesson else {
            return
        }
        guard let url = URL(string: "\(Common.link.getLessonById)/\(idLesson)") else {
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
        
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).response {
            response in
            
            SVProgressHUD.dismiss()
            
            if let error = response.error?.errorDescription {
                window.showError("Error", String(error.description.split(separator: ":")[1]) )
                return
            }
            
            guard let data = response.data else {
                return
            }
            
            self.parseLesson(data, onSuccess: onSuccess)
        }
    }
    
    func parseLesson(_ data: Data, onSuccess: (Lesson) -> Void) {
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
            window.showError("Log out failed", error.localizedDescription)
        }
    }
}

