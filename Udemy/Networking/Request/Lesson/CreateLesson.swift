//
//  CreateLesson.swift
//  Udemy
//
//  Created by Phúc Lý on 25/12/2020.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import Alamofire
import SVProgressHUD

extension RequestAPI {
    func createLesson(title: String?, idCourse: String?, order: Int?, video: Data?, document: Data?, documentName: String, onSuccess: @escaping (Lesson) -> Void) {
        guard let appDelegate = (UIApplication.shared.delegate as? AppDelegate) else {
            return
        }
        guard let window = appDelegate.window else {
            return
        }
        
        // URL
        guard let url = URL(string: Common.link.createLesson) else {
            return
        }
        
        // Params
        guard let title = title?.data(using: String.Encoding.utf8),
              let idCourse = idCourse?.data(using: String.Encoding.utf8),
              let order = order,
              let document = document,
              let video = video else {
            return
        }
        
        // Access token
        guard let accessToken = TokenManager.getAccessToken() else {
            return
        }
        
        // Headers
        let headers: HTTPHeaders = [
            "auth-token": accessToken,
            "Content-Type": "multipart/form-data; boundary=Boundary-\(UUID().uuidString)"
        ]
        
        SVProgressHUD.show()
        
        // Call API
        AF.upload(multipartFormData: { (multipartFormData) in
            let timestamp = NSDate().timeIntervalSince1970
            multipartFormData.append(video, withName: "videos", fileName: "\(timestamp).mp4", mimeType: "\(timestamp)/mp4")
            multipartFormData.append(document, withName: "docs", fileName: documentName, mimeType: "application/pdf")
            multipartFormData.append(title, withName: "title")
            multipartFormData.append(idCourse, withName: "idCourse")
            if let orderData = "\(order)".data(using: .utf8) {
                multipartFormData.append(orderData, withName: "order")
            }
            
        }, to: url, method: .post, headers: headers).response { (response) in
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
                self.parseCreateLessonJSON(data, onSuccess: onSuccess)
            }
            else if statusCode == 422 {
                self.parseErrorJSON(from: data)
            }
            else {
                self.parseMessageErrorJSON(from: data)
            }
        }
    }
    
    func parseCreateLessonJSON(_ data: Data, onSuccess: @escaping (Lesson) -> Void) {
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
            window.showError("Create lesson failed", error.localizedDescription)
        }
    }
}
