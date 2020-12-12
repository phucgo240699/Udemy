//
//  GetTokenResetPass.swift
//  Udemy
//
//  Created by Phúc Lý on 12/12/2020.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import Alamofire

extension RequestAPI {
    func getTokenResetPass(_ email: String?, onSuccess: @escaping (String?) -> Void) {
        guard let appDelegate = (UIApplication.shared.delegate as? AppDelegate) else {
            return
        }
        guard let window = appDelegate.window else {
            return
        }
        
        // Params
        guard let email = email else {
            return
        }
        let params: [String: Any] = ["email": email]
        
        // URL
        guard let url = URL(string: "\(Common.link.getTokenResetPass)") else {
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
            
            self.parseGetTokenPassJSON(data, onSuccess: onSuccess)
        }
    }
    
    func parseGetTokenPassJSON(_ data: Data, onSuccess: (String?) -> Void) {
        guard let appDelegate = (UIApplication.shared.delegate as? AppDelegate) else {
            return
        }
        guard let window = appDelegate.window else {
            return
        }
        
        do {
            let result = try JSONDecoder().decode(ErrorMessageResponse.self, from: data)
            onSuccess(result.message)
        } catch {
            window.showError("Get code failed", error.localizedDescription)
        }
    }
}
