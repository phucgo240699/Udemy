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
    func createCourse(name: String, goal: String, description: String, categoryId: String, price: Int, discount: Int, onSuccess: @escaping () -> Void) {
        
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
        
        // Params
        let params: [String: Any] = [
            "name": name,
            "goal": goal,
            "description": description,
            "categoryId": categoryId,
            "price": price,
            "discount": discount
        ]
        
        // show waiting progress
        SVProgressHUD.show()
        
        // Call API
        AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).response{
            response in
            
            // off waiting progress
            SVProgressHUD.dismiss()
            
            if let error = response.error?.errorDescription {
                window.showError("Create course failed", String(error.description.split(separator: ":")[1]))
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
                window.showError("Create course failed", "")
            }
            
        } catch {
            window.showError("Create course failed", error.localizedDescription)
        }
    }
}
