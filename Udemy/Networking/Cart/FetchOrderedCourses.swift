//
//  FetchOrderedCourses.swift
//  Udemy
//
//  Created by Phúc Lý on 17/11/2020.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import UIKit
import Alamofire

extension CartViewController {
    
//    func fetchCourseById(_ id: String?) {
//        guard let appDelegate = (UIApplication.shared.delegate as? AppDelegate) else {
//            return
//        }
//        guard let window = appDelegate.window else {
//            return
//        }
//        guard let id = id else {
//            return
//        }
//        
//        // URL
//        guard let url = URL(string: "\(Common.link.getCourseById)/\(id)") else {
//            return
//        }
//        
//        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).response {
//            response in
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
//            self.parseCourseJSON(data)
//        }
//    }
//    
//    func parseCourseJSON(_ data: Data) {
//        guard let appDelegate = (UIApplication.shared.delegate as? AppDelegate) else {
//            return
//        }
//        guard let window = appDelegate.window else {
//            return
//        }
//        
//        do {
//            let result = try JSONDecoder().decode(CoursesInCart.self, from: data)
//            self.courseDetails.append(result)
//            
//            if self.courses.count ==  appDelegate.cart.courseIds.count {
//                DispatchQueue.main.async {
//                    self.tableView.reloadData()
//                }
//            }
//            
//        } catch {
//            window.showError("Fetch course failed", error.localizedDescription)
//        }
//    }
    
}