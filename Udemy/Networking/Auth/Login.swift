//
//  UdemyLoginManager.swift
//  Udemy
//
//  Created by Phúc Lý on 9/29/20.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD

extension LoginViewController {
    func autoLogin() {
        guard let appDelegate = (UIApplication.shared.delegate as? AppDelegate) else {
            return
        }
        
        if let email = appDelegate.account.email, let password = appDelegate.account.password {
            if email.isEmptyOrSpacing() == false || password.isEmptyOrSpacing() == false {
                login(url: Common.link.login, email: email, password: password)
            }
        }
    }
    
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
        
        // show waiting progress
        SVProgressHUD.show()
        
        // Call API
        AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).response{
            response in
            
            // off waiting progress
            SVProgressHUD.dismiss()
            
            if let error = response.error?.errorDescription {
                window.showError("Login failed", error)
                return
            }
            
            guard let statusCode = response.response?.statusCode else {
                return
            }
            guard let data = response.data else {
                return
            }
            
            if statusCode == 200 { // Successful
                
                // parse result to check
                self.parseLoginJSON(from: data, response.response?.headers, email, password)
            }
            else { // Failed
                
                // parseError and show it
                self.parseErrorMessageJSON(from: data)
                
            }
            
        }
        
    }
    
    func parseLoginJSON(from data: Data, _ headers: HTTPHeaders?, _ email: String, _ password: String) {
        
        guard let appDelegate = (UIApplication.shared.delegate as? AppDelegate) else {
            return
        }
        guard let window = appDelegate.window else {
            return
        }
        do {
            let loginResponse = try JSONDecoder().decode(AccountResponse.self, from: data)
            if let active = loginResponse.active {
                if active == 1 {
                    if let headers = headers {
                        if let token = headers["auth-token"] {
                            TokenManager.setAccessToken(token)
                            
                            appDelegate.account.update(email, password, loginResponse.name, loginResponse.phone, loginResponse.gender, loginResponse.role, loginResponse.image, loginResponse.address, loginResponse.description)
                            appDelegate.account.save()
                            
                            DispatchQueue.main.async {
                                UIView.animate(withDuration: 0.5) {
                                    window.setController(.mainTab)
                                }
                            }
                        }
                    }
                }
            }
        } catch {
            window.showError("Login failed", error.localizedDescription)
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
            window.showError("Login failed", errorMessageResponse.message ?? "There is an error")
        } catch {
            window.showError("Login failed", error.localizedDescription)
        }
    }
}

