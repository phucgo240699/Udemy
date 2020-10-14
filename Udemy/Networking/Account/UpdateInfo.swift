//
//  UpdateAccount.swift
//  Udemy
//
//  Created by Phúc Lý on 10/11/20.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import UIKit
import SVProgressHUD
import Alamofire

extension InformationViewController {
    func updateInfo(_ urlString: String, _ name: String?, _ phone: String?, _ address: String?, _ description: String?, _ gender: String?) {
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
        guard let name = name, let phone = phone, let address = address, let description = description, let gender = gender else {
            window.showError("Update failed", "Not enough information")
            return
        }
        let params: [String: Any] = ["name": name, "phone": phone, "address": address, "description": description, "gender": gender]
        
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
                window.showError("Error", error)
                return
            }
            
            guard let data = response.data else {
                return
            }
            
            self.parseJSON(data)
        }
    }
    
    func parseJSON(_ data: Data) {
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
                appDelegate.account.update(appDelegate.account._id, appDelegate.account.email, appDelegate.account.password, result.user?.name, result.user?.phone, result.user?.gender, appDelegate.account.role, appDelegate.account.imageName, result.user?.address, result.user?.description)
                
                // 2. Update name to account VC
                if let updateInfoSuccessfully = updateInfoSuccessfully, let newName = result.user?.name {
                    updateInfoSuccessfully(newName)
                }
                
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
