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
    
    func parseErrorJSON(from data: Data) {
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
}
