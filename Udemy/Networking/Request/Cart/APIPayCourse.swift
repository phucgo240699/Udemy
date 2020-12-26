//
//  PayCourse.swift
//  Udemy
//
//  Created by Phúc Lý on 19/11/2020.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

//import Alamofire
//import SVProgressHUD
//
//extension RequestAPI {
//    func payCourse(_ name: String?, _ email: String?, _ stripeToken: String?, _ amount: Int?, _ idCourse: String?, _ idUser: String?) {
//        guard let appDelegate = (UIApplication.shared.delegate as? AppDelegate) else {
//            return
//        }
//        guard let window = appDelegate.window else {
//            return
//        }
//        
//        // URL
//        let rawUrl = URL(string: Common.link.payCourse)
//        guard let url = rawUrl else {
//            return
//        }
//        
//        // Params
//        guard let name = name, let email = email, let stripeToken = stripeToken, let amount = amount, let idCourse = idCourse, let idUser = idUser else {
//            window.showError("Update failed", "Not enough information")
//            return
//        }
//        let params: [String: Any] = [ "name": name, "email": email, "stripeToken": stripeToken, "amount": amount, "idCourse": idCourse, "idUser": idUser ]
//        
//        // show waiting progress
//        SVProgressHUD.show()
//        
//        // Call API
//        AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).response{
//            response in
//            
//            // off waiting progress
//            SVProgressHUD.dismiss()
//            
//            if let error = response.error?.errorDescription {
//                window.showError("Error", String(error.description.split(separator: ":")[1]) )
//                return
//            }
//            
//            guard let data = response.data else {
//                return
//            }
//            
//            self.parsePayCourseJSON(data)
//        }
//    }
//    
//    func parsePayCourseJSON(_ data: Data) {
//        guard let appDelegate = (UIApplication.shared.delegate as? AppDelegate) else {
//            return
//        }
//        guard let window = appDelegate.window else {
//            return
//        }
//        
//        do {
//            let result = try JSONDecoder().decode(UserFunc.self, from: data)
//            
//            
//        } catch {
//            window.showError("Update failed", error.localizedDescription)
//        }
//    }
//}
