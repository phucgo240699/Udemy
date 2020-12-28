//
//  APIUpdateCourse.swift
//  Udemy
//
//  Created by Phúc Lý on 28/12/2020.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import Alamofire
import SVProgressHUD

extension RequestAPI {
    func updateCourse(by idCourse: String?, name: String?, goal: String?, description: String?, categoryId: String?, price: Int?, discount: Int?, image: UIImage?, imageName: String?, onSuccess: @escaping () -> Void ) {
        guard let appDelegate = (UIApplication.shared.delegate as? AppDelegate) else {
            return
        }
        guard let window = appDelegate.window,
              let idUser = appDelegate.account._id,
              let idCourse = idCourse else {
            return
        }
        
        // URL
        guard let url = URL(string: "\(Common.link.updateCourse)/\(idCourse)") else {
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
        
        // show waiting progress
        SVProgressHUD.show()
        
        // Call API
        AF.upload(multipartFormData: { (multipartFormData) in
            if let name = name {
                if let nameData = "\(name)".data(using: String.Encoding.utf8) {
                    multipartFormData.append(nameData, withName: "name")
                }
            }
            if let goal = goal {
                if let goalData = "\(goal)".data(using: String.Encoding.utf8) {
                    multipartFormData.append(goalData, withName: "goal")
                }
            }
            if let description = description {
                if let descriptionData = "\(description)".data(using: String.Encoding.utf8) {
                    multipartFormData.append(descriptionData, withName: "description")
                }
            }
            if let categoryId = categoryId {
                if let categoryIdData = "\(categoryId)".data(using: String.Encoding.utf8) {
                    multipartFormData.append(categoryIdData, withName: "category")
                }
            }
            if let price = price {
                if let priceData = "\(price)".data(using: String.Encoding.utf8) {
                    multipartFormData.append(priceData, withName: "price")
                }
            }
            if let discount = discount {
                if let discountData = "\(discount)".data(using: String.Encoding.utf8) {
                    multipartFormData.append(discountData, withName: "discount")
                }
            }
            if let image = image, let imageName = imageName {
                if let imageData = image.jpegData(compressionQuality: 1.0) {
                    let now = Int64(Date().timeIntervalSince1970 * 1000)
                    multipartFormData.append(imageData, withName: "image", fileName: "\(imageName).jpg", mimeType: "image/jpg")
                }
            }
        }, to: url, method: .put, headers: headers).responseData { (response) in
            
            SVProgressHUD.dismiss()
            
            if let error = response.error?.errorDescription {
                window.showError("Error", String(error.description.split(separator: ":")[1]) )
                return
            }
            
            guard let data = response.data else {
                return
            }
            
            self.parseUpdateCourse(data, onSuccess: onSuccess)
        }
    }
    
    
    func parseUpdateCourse(_ data: Data, onSuccess: @escaping () -> Void) {
        guard let appDelegate = (UIApplication.shared.delegate as? AppDelegate) else {
            return
        }
        guard let window = appDelegate.window else {
            return
        }
        
        do {
            let result = try JSONDecoder().decode(UpdateCourseResponse.self, from: data)
            if result.status == "success" {
                onSuccess()
            }
            else {
                window.showError("Update course failed", "")
            }
            
        } catch {
            window.showError("Update course failed", error.localizedDescription)
        }
    }
}
