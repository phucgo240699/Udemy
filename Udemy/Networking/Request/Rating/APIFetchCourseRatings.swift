//
//  FetchRatings.swift
//  Udemy
//
//  Created by Phúc Lý on 21/11/2020.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import Alamofire

extension RequestAPI {
    func fetchRatings(by idCourse: String?, onSuccess: @escaping (([CourseRating]) -> Void)) {
        guard let appDelegate = (UIApplication.shared.delegate as? AppDelegate) else {
            return
        }
        guard let window = appDelegate.window else {
            return
        }
        guard let idCourse = idCourse else {
            return
        }
        
        // URL
        guard let url = URL(string: "\(Common.link.getRatingsByCourse)/\(idCourse)") else {
            return
        }
        
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).response {
            response in
            
            if let error = response.error?.errorDescription {
                window.showError("Error", String(error.description.split(separator: ":")[1]) )
                return
            }
            
            guard let data = response.data else {
                return
            }
            
            self.parseCourseRatingsJSON(data, onSuccess: onSuccess)
        }
    }
    
    func parseCourseRatingsJSON(_ data: Data, onSuccess: @escaping ([CourseRating]) -> Void) {
        guard let appDelegate = (UIApplication.shared.delegate as? AppDelegate) else {
            return
        }
        guard let window = appDelegate.window else {
            return
        }
        
        do {
            let result = try JSONDecoder().decode([CourseRating].self, from: data)
            onSuccess(result)
            
        } catch {
            window.showError("Log out failed", error.localizedDescription)
        }
    }
}
