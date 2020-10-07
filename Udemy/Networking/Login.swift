//
//  UdemyLoginManager.swift
//  Udemy
//
//  Created by Phúc Lý on 9/29/20.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import UIKit
import Alamofire

extension LoginViewController {
    func login(url: String, email: String?, password: String?) {
        guard let appDelegate = (UIApplication.shared.delegate as? AppDelegate) else {
            return
        }
        guard let window = appDelegate.window else {
            return
        }
        
        // URL
        let rawUrl = URL(string: url)
        guard let url = rawUrl else {
            return
        }
        
        // Params
        guard let email = email, let password = password else {
            window.showError("Login failed", "Not enough information")
            return
        }
        
        if email.isEmptyOrSpacing() || password.isEmptyOrSpacing() {
            window.showError("Login failed", "Not enough information")
            return
        }
        
        let params: [String: Any] = ["email": email, "password": password]
        
        
        // Call API
        AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).response{
            response in
            guard let statusCode = response.response?.statusCode else {
                return
            }
            guard let data = response.data else {
                return
            }
            
            if statusCode == 200 { // Successful
                // Save token
                if let headers = response.response?.headers {
                    if let token = headers["auth-token"] {
                        TokenManager.setToken(token)
                    }
                }
                
                // parse result to check
                self.parseLoginJSON(from: data)
            }
            else { // Failed
                
                // parseError and show it
                self.parseErrorMessageJSON(from: data)
                
            }
        }
        
    }
    
    func parseLoginJSON(from data: Data) {
        
        guard let appDelegate = (UIApplication.shared.delegate as? AppDelegate) else {
            return
        }
        guard let window = appDelegate.window else {
            return
        }
        do {
            let loginResponse = try JSONDecoder().decode(LoginResponse.self, from: data)
            if let active = loginResponse.active {
                if active == 1 {
                    DispatchQueue.main.async {
                        UIView.animate(withDuration: 0.5) {
                            window.setController(.mainTab)
                        }
                    }
                }
            }
        } catch {
            window.showError("Error", error.localizedDescription)
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
            window.showError("Register failed", errorMessageResponse.message ?? "There is an error")
        } catch {
            window.showError("Error", error.localizedDescription)
        }
    }
}

