//
//  FetchCourses.swift
//  Udemy
//
//  Created by Phúc Lý on 16/11/2020.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD

extension CourseViewController {
    func fetchCourses(by idUser: String?) {
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
        
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).response {
            response in
            
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
                self.parseCoursesJSON(data)
            }
            else {
                self.parseErrorMessageJSON(from: data)
            }
        }
    }
    
    func parseCoursesJSON(_ data: Data) {
        guard let appDelegate = (UIApplication.shared.delegate as? AppDelegate) else {
            return
        }
        guard let window = appDelegate.window else {
            return
        }
        
        do {
            let result = try JSONDecoder().decode([JoinedCourse].self, from: data)
            self.courses = result
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        } catch {
            window.showError("Fetch courses failed", error.localizedDescription)
        }
    }
    
    func parseErrorMessageJSON(from data: Data) {
        guard let appDelegate = (UIApplication.shared.delegate as? AppDelegate) else {
            return
        }
        guard let window = appDelegate.window else {
            return
        }
        
        do {
            let errorMessageResponse = try JSONDecoder().decode(ErrorMessageResponse.self, from: data)
            window.showError("Fetch courses failed", errorMessageResponse.message ?? "There is an error")
        } catch {
            window.showError("Fetch courses failed", error.localizedDescription)
        }
    }
}

