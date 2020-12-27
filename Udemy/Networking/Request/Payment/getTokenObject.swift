//
//  getTokenObject.swift
//  Udemy
//
//  Created by Phúc Lý on 26/12/2020.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import Alamofire
import SVProgressHUD

extension RequestAPI {
    func getStripeTokenObject(params: CardStripeRequest, onSuccess: @escaping (StripeResponse) -> Void) {
        guard let appDelegate = (UIApplication.shared.delegate as? AppDelegate) else {
            return
        }
        guard let window = appDelegate.window else {
            return
        }
        
        guard let url = URL(string: Common.link.getStripeTokenObject) else {
            return
        }
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer sk_test_51I1TlzABLqtAl4aBD4qzy8PQcrLD1eYzIgzeqzDUvqztrSp7QQvahiWlFQQiUwMc1yqsfuWsTUxK3svxnBhoT3XC00atVjZ0X8",
            "Content-Type": "application/x-www-form-urlencoded"
            
        ]
        
        let _params: [String: Any] = [
            "card": [
                "number": "4242424242424242",
                "exp_month": params.card?.exp_month,
                "exp_year": params.card?.exp_year,
                "cvc": "314"
            ]
        ]
        
        SVProgressHUD.show()
        
        AF.request(url, method: .post, parameters: _params, encoding: URLEncoding.default, headers: headers).response { (response) in
            if let error = response.error?.errorDescription {
                SVProgressHUD.dismiss()
                window.showError("Error", String(error.description.split(separator: ":")[1]) )
                return
            }
            
            guard let data = response.data else {
                SVProgressHUD.dismiss()
                return
            }
            
            self.parseGetStripeTokenObjectJSON(data, onSuccess: onSuccess)
        }
    }
    
    func parseGetStripeTokenObjectJSON(_ data: Data, onSuccess: @escaping (StripeResponse) -> Void) {
        guard let appDelegate = (UIApplication.shared.delegate as? AppDelegate) else {
            SVProgressHUD.dismiss()
            return
        }
        guard let window = appDelegate.window else {
            SVProgressHUD.dismiss()
            return
        }
        
        do {
            let result = try JSONDecoder().decode(StripeResponse.self, from: data)
            onSuccess(result)
            
        } catch {
            SVProgressHUD.dismiss()
            window.showError("Log out failed", error.localizedDescription)
        }
    }
}
