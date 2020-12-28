//
//  UpdateProgress.swift
//  Udemy
//
//  Created by Phúc Lý on 28/12/2020.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import Alamofire

extension RequestAPI {
    func updateProgressLesson(idCourse: String?, idLesson: String?, onSuccess: @escaping () -> Void) {
        guard let appDelegate = (UIApplication.shared.delegate as? AppDelegate) else {
            return
        }
        guard let window = appDelegate.window else {
            return
        }
        
        guard let idCourse = idCourse,
              let idLesson = idLesson,
              let idUser = appDelegate.account._id else {
            return
        }
        
        guard let url = URL(string: "\(Common.link.updateProgressLesson)/\(idUser)/\(idCourse)/\(idLesson)") else {
            return
        }
        
        AF.request(url, method: .put, parameters: nil, encoding: JSONEncoding.default, headers: nil).response { (response) in
            if let error = response.error?.errorDescription {
                window.showError("Error", String(error.description.split(separator: ":")[1]) )
                return
            }
            
            guard let statusCode = response.response?.statusCode else {
                return
            }
            
            if statusCode == 200 {
                onSuccess()
            }
        }
        
    }
}
