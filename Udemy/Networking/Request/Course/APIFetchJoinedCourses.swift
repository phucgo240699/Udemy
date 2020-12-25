//
//  APIFetchJoinedCourses.swift
//  Udemy
//
//  Created by Phúc Lý on 19/11/2020.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import Alamofire
import SVProgressHUD

extension RequestAPI {
    func fetchJoinedCourses(by idUser: String?, onSuccess: @escaping ([JoinedCourse]) -> Void) {
        guard let appDelegate = (UIApplication.shared.delegate as? AppDelegate) else {
            return
        }
        guard let window = appDelegate.window else {
            return
        }
        guard let idUser = idUser else {
            return
        }
        
        // URL
        guard let url = URL(string: "\(Common.link.getJoinedCoursesByUser)/\(idUser)") else {
            return
        }
        
        SVProgressHUD.show()
        
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).response {
            response in
            
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
                self.parseJoinedCoursesJSON(data, onSuccess: onSuccess)
            }
            else {
                self.parseMessageErrorJSON(from: data)
            }
        }
    }
    
    func parseJoinedCoursesJSON(_ data: Data, onSuccess: @escaping ([JoinedCourse]) -> Void) {
        guard let appDelegate = (UIApplication.shared.delegate as? AppDelegate) else {
            return
        }
        guard let window = appDelegate.window else {
            return
        }
        
        do {
            let result = try JSONDecoder().decode([JoinedCourse].self, from: data)
            onSuccess(result)
            
        } catch {
            window.showError("Fetch courses failed", error.localizedDescription)
        }
    }
}
