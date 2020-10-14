//
//  UpdateAvatar.swift
//  Udemy
//
//  Created by Phúc Lý on 10/13/20.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD

extension AvatarViewController {
    func updateAvatarNameToServer(_ urlString: String, _ image: UIImage, _ imageName: String) {
        guard let appDelegate = (UIApplication.shared.delegate as? AppDelegate) else {
            return
        }
        guard let window = appDelegate.window else {
            return
        }
        
        // imageData
        guard let imageData = image.pngData() else {
            return
        }
        
        // Account Id
        guard let accountId = appDelegate.account._id else {
            return
        }
        
        // URL
        let rawUrl = URL(string: urlString)
        guard let url = rawUrl else {
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
        
        // show waiting progress
        SVProgressHUD.show()
        
        // Request
        var rawRequest: URLRequest?
        do {
            rawRequest = try URLRequest(url: url, method: .put, headers: headers)
        } catch {
            window.showError("Failed", error.localizedDescription)
        }
        
        guard let request = rawRequest else {
            return
        }
        
        // Call API
        AF.upload(multipartFormData: { (multipartFormData) in
            multipartFormData.append(imageData, withName: "image", fileName: "\(accountId).jpg", mimeType: "image/jpg")
            
        }, with: request).response { (response) in
            
            SVProgressHUD.dismiss()
            
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
                appDelegate.account.imageName = result.user?.imageName
                
                // 2. Update avatar to account VC
                if let updateAvatarSuccessfully = updateAvatarSuccessfully, let image = avatarImageView?.image {
                    
                    updateAvatarSuccessfully(image)
                }
                
                // 3.Return
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
