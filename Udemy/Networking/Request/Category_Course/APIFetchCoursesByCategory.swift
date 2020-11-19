//
//  APIFetchCoursesByCategory.swift
//  Udemy
//
//  Created by Phúc Lý on 19/11/2020.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import Alamofire
import SVProgressHUD

extension RequestAPI {
    func fetchCourses(by categoryId: String?, onSuccess: @escaping ([Course]) -> Void) {
        guard let appDelegate = (UIApplication.shared.delegate as? AppDelegate) else {
            return
        }
        guard let window = appDelegate.window else {
            return
        }
        guard let categoryId = categoryId else {
            return
        }
        
        // URL
        guard let url = URL(string: "\(Common.link.getCoursesByCategory)/\(categoryId)") else {
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
            
            self.parseCoursesByCategoryJSON(data, onSuccess: onSuccess)
        }
    }

    func parseCoursesByCategoryJSON(_ data: Data, onSuccess: @escaping ([Course]) -> Void) {
        guard let appDelegate = (UIApplication.shared.delegate as? AppDelegate) else {
            return
        }
        guard let window = appDelegate.window else {
            return
        }
        
        do {
            let result = try JSONDecoder().decode([Course].self, from: data)
            onSuccess(result)
        } catch {
            window.showError("Fetch course's detail failed", error.localizedDescription)
        }
    }
}
