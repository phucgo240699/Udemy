//
//  Activate.swift
//  Udemy
//
//  Created by Phúc Lý on 10/6/20.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

extension ActivationViewController {
    func active(url: String, email: String?, activeToken: String? ) {
        
        // URL
        let rawUrl = URL(string: url)
        guard let url = rawUrl else {
            return
        }
        
        // Params
        guard let email = email, let activeToken = activeToken else {
            return
        }
        
        if email.isEmptyOrSpacing() || activeToken.isEmptyOrSpacing() {
            return
        }
        
        let params: [String: Any] = ["email": email, "activeToken": activeToken]
        
        
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
                self.parseActivationJSON(from: data)
            }
            else { // Failed
                
                // parseError and show it
                self.parseErrorJSON(from: data)
                
            }
        }
        
    }
    
    func parseActivationJSON(from data: Data) {
        
        guard let appDelegate = (UIApplication.shared.delegate as? AppDelegate) else {
            return
        }
        guard let window = appDelegate.window else {
            return
        }
        do {
            let activationResponse = try JSONDecoder().decode(ActivationResponse.self, from: data)
            if let active = activationResponse.active {
                if active == 1 {
                    window.notificate(UIImage(named: Common.imageName.done), "Activate successfully", "You can log in now")
                    UIView.animate(withDuration: 0.5) {
                        self.navigationController?.popToRootViewController(animated: true)
                    }
                }
            }
        } catch {
            
            window.showError("Error", error.localizedDescription)
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
            let errorResponse = try JSONDecoder().decode(ErrorMessageResponse.self, from: data)
            window.showError("Register failed", errorResponse.message ?? "There is an error")
        } catch {
            window.showError("Error", error.localizedDescription)
        }
    }
}
