//
//  FeatureViewController.swift
//  Udemy
//
//  Created by Phúc Lý on 10/1/20.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import Foundation
import UIKit

class FeatureViewController: UIViewController {
    
    var tableView: UITableView?
    var width:CGFloat {
        get {
            return self.view.bounds.width
        }
    }
    var height: CGFloat {
        get {
            return self.view.bounds.height
        }
    }
    var rowHeight: CGFloat  {
        get {
            return height * 0.3
        }
    }
    var listSessions: [String] = ["Categories", "Newest", "Free"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Common.color.purple
        
        initializeTableView()
    }
}


// MARK: - UITableViewDelegates
extension FeatureViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return rowHeight
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listSessions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "featureCell", for: indexPath) as! FeatureTableViewCell
        return cell
    }
    
    
}
