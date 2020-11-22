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
    
    var ratings: [CourseRating] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationItem.title = "Ratings"
        
        setupUI()
    }

    func setupUI() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        tableView.register(UINib(nibName: "RatingTableViewCell", bundle: nil), forCellReuseIdentifier: cellID)
    }
}

// MARK: - UITableViewDataSource
extension RatingsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ratings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? RatingTableViewCell else {
            return UITableViewCell()
        }
        
        cell.setData(courseRating: ratings[indexPath.row])
        
        return cell
    }
}


//
extension RatingsViewController: UITableViewDelegate {
    
}
