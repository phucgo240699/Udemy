//
//  ResetPassword.swift
//  Udemy
//
//  Created by Phúc Lý on 12/12/2020.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import Alamofire

extension RequestAPI {
    func resetPassword(_ email: String?, _ password: String?, _ token: String?, onSuccess: @escaping () -> Void) {
        guard let appDelegate = (UIApplication.shared.delegate as? AppDelegate) else {
            return
        }
        guard let window = appDelegate.window else {
            return
        }
        
        // Params
        guard let email = email, let password = password, let token = token else {
            return
        }
        let params: [String: Any] = [
            "email": email,
            "password": password,
            "token": token
        ]
        
        // URL
        guard let url = URL(string: "\(Common.link.resetPass)") else {
            return
        }
        
        AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).response {
            response in
            
            if let error = response.error?.errorDescription {
                window.showError("Error", String(error.description.split(separator: ":")[1]) )
                return
            }
            
            guard let data = response.data else {
                return
            }
            
            self.parseResetPassJSON(data, onSuccess: onSuccess)
        }
    }
    
    func parseResetPassJSON(_ data: Data, onSuccess: () -> Void) {
        guard let appDelegate = (UIApplication.shared.delegate as? AppDelegate) else {
            return
        }
        guard let window = appDelegate.window else {
            return
        }
        
        do {
            let result = try JSONDecoder().decode(ResetPassRess.self, from: data)
            
            onSuccess()
        } catch {
            window.showError("Reset password failed", error.localizedDescription)
        }
    }
}
