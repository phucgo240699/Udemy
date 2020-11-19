//
//  FetchCategories.swift
//  Udemy
//
//  Created by Phúc Lý on 19/11/2020.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD

extension RequestAPI {
    func fetchCategories(onSuccess: @escaping ([Category]) -> Void) {
        guard let appDelegate = (UIApplication.shared.delegate as? AppDelegate) else {
            return
        }
        guard let window = appDelegate.window else {
            return
        }
        
        // URL
        guard let url = URL(string: Common.link.getAllCategories) else {
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
            
            self.parseCategoriesJSON(data, onSuccess: onSuccess)
        }
    }
    
    func parseCategoriesJSON(_ data: Data, onSuccess: @escaping ([Category]) -> Void) {
        guard let appDelegate = (UIApplication.shared.delegate as? AppDelegate) else {
            return
        }
        guard let window = appDelegate.window else {
            return
        }
        
        do {
            let result = try JSONDecoder().decode([Category].self, from: data)
            onSuccess(result)
            
        } catch {
            window.showError("Log out failed", error.localizedDescription)
        }
    }
}
