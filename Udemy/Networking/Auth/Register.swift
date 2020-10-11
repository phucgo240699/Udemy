
//
//  UdemyRegisterManager.swift
//  Udemy
//
//  Created by Phúc Lý on 9/29/20.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import SVProgressHUD
import UIKit
import Alamofire

extension RegisterViewController {
    func register(urlString: String, email: String?, password: String?, name: String?, phone: String?, address: String?, description: String?, gender: String? ) {
        guard let appDelegate = (UIApplication.shared.delegate as? AppDelegate) else {
            return
        }
        guard let window = appDelegate.window else {
            return
        }
        
        // URL
        let rawUrl = URL(string: urlString)
        guard let url = rawUrl else {
            return
        }
        
        // Params
        guard let email = email, let password = password, let name = name, let phone = phone, let address = address, let description = description, let gender = gender else {
            window.showError("Register failed", "Not enough information")
            return
        }
        if email.isEmptyOrSpacing() || password.isEmptyOrSpacing() || name.isEmptyOrSpacing() || phone.isEmptyOrSpacing() || address.isEmptyOrSpacing() || description.isEmptyOrSpacing() ||  gender.isEmptyOrSpacing() || gender == "Gender" {
            window.showError("Register failed", "Not enough information")
            return
        }
        let params: [String: Any] = ["email": email, "password": password, "name": name, "phone": phone, "address": address, "description": description, "gender": gender]
        
        // show waiting progress
        SVProgressHUD.show()
        
        // Call API
        AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).response{
            response in
            
            // off waiting progress
            SVProgressHUD.dismiss()
            
            if let error = response.error?.errorDescription {
                window.showError("Register failed", error)
                return
            }
            
            guard let statusCode = response.response?.statusCode else {
                return
            }
            guard let data = response.data else {
                return
            }
            
            if statusCode == 200 { // Successful
                self.parseRegisterJSON(from: data)
            }
            else if statusCode == 422 {
                // parseError and show it
                self.parseErrorJSON(from: data)
            }
            
            else  { // Failed
                // parseError and show it
                self.parseErrorMessageJSON(from: data)
                
            }
        }
        
    }
    
    
    func parseRegisterJSON(from data: Data) {
        do {
            let registerResponse = try JSONDecoder().decode(AccountResponse.self, from: data)
            if let email = registerResponse.email {
                let activationViewController = ActivationViewController()
                activationViewController.email = email
                navigationController?.pushViewController(activationViewController, animated: true)
            }
        } catch {
            guard let appDelegate = (UIApplication.shared.delegate as? AppDelegate) else {
                return
            }
            guard let window = appDelegate.window else {
                return
            }
            
            window.showError("Register failed", error.localizedDescription)
        }
    }
    
    func parseErrorJSON(from data: Data) {
        guard let appDelegate = (UIApplication.shared.delegate as? AppDelegate) else {
            return
        }
        guard let window = appDelegate.window else {
            return
        }
        
        do {
            let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
            window.showError("Register failed", errorResponse.errors[0].msg ?? "There is an error")
        } catch {
            window.showError("Register failed", error.localizedDescription)
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
            window.showError("Register failed", error.localizedDescription)
        }
    }
    
}
