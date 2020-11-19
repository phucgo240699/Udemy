//
//  APICheckJoinedCourse.swift
//  Udemy
//
//  Created by Phúc Lý on 19/11/2020.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import Alamofire
import SVProgressHUD

extension RequestAPI {
    func checkJoinedCourse(idUser: String?, idCourse: String?, onSucces: @escaping (Bool?) -> Void) {
        guard let appDelegate = (UIApplication.shared.delegate as? AppDelegate) else {
            return
        }
        guard let window = appDelegate.window else {
            return
        }
        
        // Params
        guard let idUser = idUser, let idCourse = idCourse else {
            window.showError("check join failed", "Not enough information")
            return
        }
        
        // URL
        let rawUrl = URL(string: "\(Common.link.checkJoinedCourse)/\(idUser)/\(idCourse)")
        guard let url = rawUrl else {
            return
        }
        
        // Call API
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).response{
            response in
            
            if let error = response.error?.errorDescription {
                window.showError("Error", String(error.description.split(separator: ":")[1]))
                return
            }
            guard let statusCode = response.response?.statusCode else {
                return
            }
            guard let data = response.data else {
                return
            }
            
            if statusCode == 200 {
                self.parseCheckJoinedCourseJSON(data, onSucces: onSucces)
            }
        }
    }
    
    func parseCheckJoinedCourseJSON(_ data: Data, onSucces: @escaping (Bool?) -> Void) {
        guard let appDelegate = (UIApplication.shared.delegate as? AppDelegate) else {
            return
        }
        guard let window = appDelegate.window else {
            return
        }
        
        do {
            let result = try JSONDecoder().decode(IsJoinedCourse.self, from: data)
            onSucces(result.isJoined)
        } catch {
            window.showError("Error", error.localizedDescription)
        }
    }
}
