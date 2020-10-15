//
//  UpdatePassword.swift
//  Udemy
//
//  Created by Phúc Lý on 10/12/20.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD

extension PasswordViewController {
    func updatePassword(_ urlString: String, _ oldPassword: String?, _ newPassword: String?) {
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
        guard let oldPassword = oldPassword, let newPassword = newPassword else {
            window.showError("Update failed", "Not enough information")
            return
        }
        let params: [String: Any] = ["oldpassword": oldPassword, "newpassword": newPassword]
        
        // Access token
        guard let accessToken = TokenManager.getAccessToken() else {
            return
        }
        
        // Headers
        let headers: HTTPHeaders = [
            "auth-token": accessToken,
            "Accept": "application/json"
        ]
        
        // show waiting progress
        SVProgressHUD.show()
        
        // Call API
        AF.request(url, method: .put, parameters: params, encoding: JSONEncoding.default, headers: headers).response{
            response in
            
            // off waiting progress
            SVProgressHUD.dismiss()
            
            if let error = response.error?.errorDescription {
                window.showError("Error", String(error.description.split(separator: ":")[1]))
                return
            }
            
            guard let data = response.data else {
                return
            }
            
            self.parseJSON(data, newPassword)
        }
    }
    
    func parseJSON(_ data: Data, _ newPassword: String) {
        guard let appDelegate = (UIApplication.shared.delegate as? AppDelegate) else {
            return
        }
        guard let window = appDelegate.window else {
            return
        }
        
        do {
            let result = try JSONDecoder().decode(UserFunc.self, from: data)
            if result.status == "success" {
                
                // Success:
                // 1. Update account variable
                appDelegate.account.password = newPassword
                
                // 2. Save email, pass to local
                appDelegate.account.save()
                
                // 3. Return
                navigationController?.popViewController(animated: true)
                
                // 4. Notificate
                window.notificate(UIImage(named: Common.imageName.done), "Updated Successfully", "")
            }
            else {
                window.showError("Update failed", result.status ?? "")
                return
            }
            
        } catch {
            window.showError("Update failed", error.localizedDescription)
        }
    }
}
