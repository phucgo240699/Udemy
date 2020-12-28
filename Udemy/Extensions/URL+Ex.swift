//
//  URL+Ex.swift
//  Udemy
//
//  Created by Phúc Lý on 28/12/2020.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import Foundation

extension URL {
    func getDocument(handler : @escaping (Data) -> Void) {
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        var request = URLRequest(url: self)
        request.httpMethod = "GET"
        let task = session.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            if (error == nil) {
                // Success
                DispatchQueue.main.async(execute: {
                    //this is an async operation, use handler to handle the result
                    handler(data!)
                })

            }
            else {
                // Failure
                print("Failure: %@", error!.localizedDescription)
            }
        })
        task.resume()
    }
}
