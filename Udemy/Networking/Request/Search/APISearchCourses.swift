//
//  APISearchCourses.swift
//  Udemy
//
//  Created by Phúc Lý on 19/11/2020.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import Alamofire
import SVProgressHUD

extension RequestAPI {
    func searchCourses(by title: String?, onSuccess: @escaping ([RegularCourse]) -> Void) {
        guard let appDelegate = (UIApplication.shared.delegate as? AppDelegate) else {
            return
        }
        guard let window = appDelegate.window else {
            return
        }
        guard let title = title else {
            return
        }
        let validateTitle: String = title.split(separator: " ").joined(separator: "%20")
        
        // URL
        guard let url = URL(string: "\(Common.link.searchCoursesByTitle)/\(validateTitle)") else {
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
            
            guard let data = response.data else {
                return
            }
            
            guard let statusCode = response.response?.statusCode else {
                return
            }
            
            if statusCode == 200 {
                self.parseSearchCoursesJSON(data, onSuccess: onSuccess)
            }
            
        }
    }
    
    
    func parseSearchCoursesJSON(_ data: Data, onSuccess: @escaping ([RegularCourse]) -> Void) {
        guard let appDelegate = (UIApplication.shared.delegate as? AppDelegate) else {
            return
        }
        guard let window = appDelegate.window else {
            return
        }
        
        do {
            let result = try JSONDecoder().decode([RegularCourse].self, from: data)
            onSuccess(result)
            
        } catch {
            window.showError("Search courses failed", error.localizedDescription)
        }
    }
}
