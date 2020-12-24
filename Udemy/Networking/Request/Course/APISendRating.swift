//
//  APISendRating.swift
//  Udemy
//
//  Created by Phúc Lý on 19/11/2020.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import Alamofire
import SVProgressHUD

extension RequestAPI {
    func sendRating(numStar: Int?, content: String?, idUser: String?, idCourse: String?, onSuccess: @escaping () -> Void) {
        guard let appDelegate = (UIApplication.shared.delegate as? AppDelegate) else {
            return
        }
        guard let window = appDelegate.window else {
            return
        }
        
        // URL
        let rawUrl = URL(string: Common.link.sendRating)
        guard let url = rawUrl else {
            return
        }
        
        // Params
        guard let idUser = idUser, let idCourse = idCourse, let numStar = numStar, let content = content else {
            window.showError("Rating failed", "Not enough information")
            return
        }
        let params: [String: Any] = ["idUser": idUser, "idCourse": idCourse, "content": content, "numStar": numStar]
        
        // show waiting progress
        SVProgressHUD.show()
        
        // Call API
        AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).response{
            response in
            
            // off waiting progress
            SVProgressHUD.dismiss()
            
            if let error = response.error?.errorDescription {
                window.showError("Error", String(error.description.split(separator: ":")[1]) )
                return
            }
            
            guard let statusCode = response.response?.statusCode else {
                return
            }
            
            guard let data = response.data else {
                return
            }
            
            if statusCode == 200 {
                onSuccess()
            }
            else {
                self.parseErrorJSON(from: data)
            }
        }
    }
}
