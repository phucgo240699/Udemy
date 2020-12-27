//
//  APICreateCourse.swift
//  Udemy
//
//  Created by Phúc Lý on 26/12/2020.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import Alamofire
import SVProgressHUD

extension RequestAPI {
    func createCourse(name: String, goal: String, description: String, categoryId: String, price: Int, discount: Int, image: UIImage?, onSuccess: @escaping () -> Void) {
        
        guard let appDelegate = (UIApplication.shared.delegate as? AppDelegate) else {
            return
        }
        guard let window = appDelegate.window else {
            return
        }
        
        // URL
        guard let url = URL(string: "\(Common.link.createCourse)") else {
            return
        }
        
        // Access token
        guard let accessToken = TokenManager.getAccessToken() else {
            return
        }
        
        // Headers
        let headers: HTTPHeaders = [
            "auth-token": accessToken,
            "Content-Type": "multipart/form-data"
        ]
        
//        // Params
//        let params: [String: Any] = [
//            "name": name,
//            "goal": goal,
//            "description": description,
//            "categoryId": categoryId,
//            "price": price,
//            "discount": discount
//        ]
        
        // show waiting progress
        SVProgressHUD.show()
        
        // Call API
        AF.upload(multipartFormData: { (multipartFormData) in
            if let nameData = "\(name)".data(using: String.Encoding.utf8) {
                multipartFormData.append(nameData, withName: "name")
            }
            if let goalData = "\(goal)".data(using: String.Encoding.utf8) {
                multipartFormData.append(goalData, withName: "goal")
            }
            if let descriptionData = "\(description)".data(using: String.Encoding.utf8) {
                multipartFormData.append(descriptionData, withName: "description")
            }
            if let categoryIdData = "\(categoryId)".data(using: String.Encoding.utf8) {
                multipartFormData.append(categoryIdData, withName: "category")
            }
            if let priceData = "\(price)".data(using: String.Encoding.utf8) {
                multipartFormData.append(priceData, withName: "price")
            }
            if let discountData = "\(discount)".data(using: String.Encoding.utf8) {
                multipartFormData.append(discountData, withName: "discount")
            }
            if let imageData = image?.jpegData(compressionQuality: 1.0) {
                let now = Int64(Date().timeIntervalSince1970 * 1000)
                multipartFormData.append(imageData, withName: "image", fileName: "courseThumbnail\(now).jpg", mimeType: "image/jpg")
            }
        }, to: url, method: .post, headers: headers).responseData { (response) in
            
            SVProgressHUD.dismiss()
            
            if let error = response.error?.errorDescription {
                window.showError("Error", String(error.description.split(separator: ":")[1]) )
                return
            }
            
            guard let data = response.data else {
                return
            }
            
            self.parseCreateCourse(data, onSuccess: onSuccess)
        }
        
    }
    
    func parseCreateCourse(_ data: Data, onSuccess: @escaping () -> Void) {
        guard let appDelegate = (UIApplication.shared.delegate as? AppDelegate) else {
            return
        }
        guard let window = appDelegate.window else {
            return
        }
        
        do {
            let result = try JSONDecoder().decode(CreateCourseResponse.self, from: data)
            if result.status == "success" {
                onSuccess()
            }
            else {
                window.showError("Create course failed", result.err.debugDescription)
            }
            
        } catch {
            window.showError("Create course failed", error.localizedDescription)
        }
    }
}
