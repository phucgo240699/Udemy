//
//  FetchRelatedCourses.swift
//  Udemy
//
//  Created by Phúc Lý on 16/11/2020.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import UIKit
import Alamofire

extension CourseDetailVC {
    func fetchRelatedCourses(by categoryId: String?) {
        guard let appDelegate = (UIApplication.shared.delegate as? AppDelegate) else {
            return
        }
        guard let window = appDelegate.window else {
            return
        }
        guard let categoryId = categoryId else {
            return
        }
        
        // URL
        guard let url = URL(string: "\(Common.link.getCoursesByCategory)/\(categoryId)") else {
            return
        }
        
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).response {
            response in
            
            if let error = response.error?.errorDescription {
                window.showError("Error", String(error.description.split(separator: ":")[1]) )
                return
            }
            
            guard let data = response.data else {
                return
            }
            
            self.parseRelatedCoursesJSON(data)
        }
    }
    
    func parseRelatedCoursesJSON(_ data: Data) {
        guard let appDelegate = (UIApplication.shared.delegate as? AppDelegate) else {
            return
        }
        guard let window = appDelegate.window else {
            return
        }
        
        do {
            let result = try JSONDecoder().decode([Course].self, from: data)
            for index in 0 ..< cellTypes.count {
                if cellTypes[index] == .RelatedCourses {
                    if let relatedCoursesCLV = (self.tableView.cellForRow(at: IndexPath(row: index, section: 0)) as? CourseDetailRelatedCoursesCell) {
                    
                        relatedCoursesCLV.courses = result
                        
                        DispatchQueue.main.async {
                            relatedCoursesCLV.collectionView.reloadData()
                        }
                    }
                }
            }
            
        } catch {
            window.showError("Fetch course's detail failed", error.localizedDescription)
        }
    }
}
