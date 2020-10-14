//
//  FeaturedView.swift
//  Udemy
//
//  Created by Phúc Lý on 10/2/20.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import Foundation
import UIKit

extension FeatureViewController {
    func initializeTableView() {
        tableView = UITableView(frame: view.bounds, style: .grouped)
        guard let tableView = tableView else {
            return
        }
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FeatureTableViewCell.self, forCellReuseIdentifier: "featureCell")
        
        tableView.rowHeight = rowHeight
        tableView.separatorStyle = .none
        tableView.backgroundColor = Common.color.silverBackground
    }
}
