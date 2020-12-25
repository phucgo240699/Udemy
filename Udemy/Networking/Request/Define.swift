//
//  Define.swift
//  Udemy
//
//  Created by Phúc Lý on 19/11/2020.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import UIKit

class RequestAPI {
    static let shared = RequestAPI()
    
    func parseMessageErrorJSON(from data: Data) {
        guard let appDelegate = (UIApplication.shared.delegate as? AppDelegate) else {
            return
        }
        guard let window = appDelegate.window else {
            return
        }
        
        do {
            let errorMessageResponse = try JSONDecoder().decode(ErrorMessageResponse.self, from: data)
            window.showError("Request failed", errorMessageResponse.message ?? "There is an error")
        } catch {
            window.showError("Request failed", error.localizedDescription)
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
}
