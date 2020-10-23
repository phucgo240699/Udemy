//
//  FetchTopCourses.swift
//  Udemy
//
//  Created by Phúc Lý on 10/23/20.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import UIKit
import Alamofire

extension FeatureViewController {
    func fetchTopCourses() {
        guard let appDelegate = (UIApplication.shared.delegate as? AppDelegate) else {
            return
        }
        guard let window = appDelegate.window else {
            return
        }
        
        // URL
        guard let url = URL(string: Common.link.getTopCourses) else {
            return
        }
        
        // Access token
        guard let accessToken = TokenManager.getAccessToken() else {
            return
        }
        
        // Headers
        let headers: HTTPHeaders = [
            "auth-token": accessToken,
            "Accept": "application/json"
        ]
        
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).response {
            response in
            
            if let error = response.error?.errorDescription {
                window.showError("Error", String(error.description.split(separator: ":")[1]) )
                return
            }
            
            guard let data = response.data else {
                return
            }
            
            self.parseTopCoursesJSON(data)
        }
    }
    
    func parseTopCoursesJSON(_ data: Data) {
        guard let appDelegate = (UIApplication.shared.delegate as? AppDelegate) else {
            return
        }
        guard let window = appDelegate.window else {
            return
        }
        
        do {
            let result = try JSONDecoder().decode([Course].self, from: data)
            self.listTopCourses = result
            
            DispatchQueue.main.async {
                self.topCoursesCollectionView?.reloadData()
            }
            
        } catch {
            window.showError("Log out failed", error.localizedDescription)
        }
    }
}
