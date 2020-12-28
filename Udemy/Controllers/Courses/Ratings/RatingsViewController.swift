//
//  RatingsViewController.swift
//  Udemy
//
//  Created by Phúc Lý on 22/11/2020.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import UIKit

fileprivate let cellID = "ratingsViewControllerCell"

class RatingsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var refreshControl: UIRefreshControl = UIRefreshControl()
    
    var idCourse: String?
    var courseRatings: [CourseRating] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationItem.title = "Ratings"
        
        setupUI()
        adaptData()
    }

    func setupUI() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        tableView.register(UINib(nibName: "RatingTableViewCell", bundle: nil), forCellReuseIdentifier: cellID)
        
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    @objc func refresh(_ sender: UIRefreshControl) {
        refreshControl.endRefreshing()
        adaptData()
    }
    
    func adaptData() {
        RequestAPI.shared.fetchRatings(by: idCourse) { (ratings) in
            self.courseRatings = ratings
            
            self.tableView.reloadData()
        }
    }
}

// MARK: - UITableViewDataSource
extension RatingsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courseRatings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? RatingTableViewCell else {
            return UITableViewCell()
        }
        
        cell.setData(courseRating: courseRatings[indexPath.row])
        
        return cell
    }
}


//
extension RatingsViewController: UITableViewDelegate {
    
}
