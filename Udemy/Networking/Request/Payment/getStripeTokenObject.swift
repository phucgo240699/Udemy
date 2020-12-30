//
//  getTokenObject.swift
//  Udemy
//
//  Created by Phúc Lý on 26/12/2020.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import Alamofire
import Foundation
import SVProgressHUD

extension RequestAPI {
    func getStripeTokenObject(stripeToken: String?, params: CardStripeRequest, onSuccess: @escaping (StripeResponse) -> Void) {
        //        guard let appDelegate = (UIApplication.shared.delegate as? AppDelegate) else {
        //            return
        //        }
        //        guard let window = appDelegate.window else {
        //            return
        //        }
        //
                guard let stripeToken = stripeToken,
                      let numbers = params.card?.number,
                      let exp_month = params.card?.exp_month,
                      let exp_year = params.card?.exp_year,
                      let cvc = params.card?.cvc else {
                    return
                }
        //
        //        guard let url = URL(string: Common.link.getStripeTokenObject) else {
        //            return
        //        }
        //
        //        let headers: HTTPHeaders = [
        //            "Authorization": "Bearer \(stripeToken)",
        //            "Content-Type": "application/x-www-form-urlencoded"
        //
        //        ]
        //
        //        let _params = [
        //            "card": [
        //                "number": numbers,
        //                "exp_month": exp_month,
        //                "exp_year": exp_year,
        //                "cvc": cvc
        //            ]
        //        ]
        //
        //        SVProgressHUD.show()
        //
        //        AF.request(url, method: .post, parameters: _params, encoding: JSONEncoding.default, headers: headers).response { (response) in
        //
        //
        ////        AF.request(url, method: .post, parameters: _params, encoder: JSONParameterEncoder.default, headers: headers).response { (response) in
        //            if let error = response.error?.errorDescription {
        //                SVProgressHUD.dismiss()
        //                window.showError("Error", String(error.description.split(separator: ":")[1]) )
        //                return
        //            }
        //
        //            guard let data = response.data,
        //                  let statusCode = response.response?.statusCode else {
        //                SVProgressHUD.dismiss()
        //                return
        //            }
        //
        //            if statusCode == 200 {
        //                self.parseGetStripeTokenObjectJSON(data, onSuccess: onSuccess)
        //            }
        //            else {
        //                SVProgressHUD.dismiss()
        //                window.showError("Paid failed", "Can't get stripe token object")
        //            }
        //        }
        
        
        let parameters = "card%5Bnumber%5D=\(numbers)&card%5Bexp_month%5D=\(exp_month)&card%5Bexp_year%5D=\(exp_year)&card%5Bcvc%5D=\(cvc)"
        let postData =  parameters.data(using: .utf8)
        
        var request = URLRequest(url: URL(string: Common.link.getStripeTokenObject)!,timeoutInterval: Double.infinity)
        request.addValue("Bearer \(stripeToken)", forHTTPHeaderField: "Authorization")
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.addValue("lang=curl; __stripe_orig_props=%7B%22referrer%22%3A%22%22%2C%22landing%22%3A%22https%3A%2F%2Fstripe.com%2Fdocs%2Fapi%2Ftokens%2Fobject%22%7D", forHTTPHeaderField: "Cookie")
        
        request.httpMethod = "POST"
        request.httpBody = postData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                return
            }
            print(String(data: data, encoding: .utf8)!)
            
            self.parseGetStripeTokenObjectJSON(data, onSuccess: onSuccess)
        }
        
        task.resume()
    }
    
    func parseGetStripeTokenObjectJSON(_ data: Data, onSuccess: @escaping (StripeResponse) -> Void) {
        
        do {
            let result = try JSONDecoder().decode(StripeResponse.self, from: data)
            onSuccess(result)
            
        } catch {
            print(error)
        }
    }
}
