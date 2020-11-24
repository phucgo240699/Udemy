//
//  CourseDetailRatingCell.swift
//  Udemy
//
//  Created by Phúc Lý on 21/11/2020.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import UIKit

fileprivate let cellID = "courseDetailRatingCell"
fileprivate let cellHeight: CGFloat = 120.0
fileprivate let footerHeight: CGFloat = 50.0

class CourseDetailRatingCell: UITableViewCell {
    
    // Closure
    var onTapShowMore: (([CourseRating]) -> Void)?

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var showMoreButton: UIButton!
    
    var ratings: [CourseRating] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupUI() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "RatingTableViewCell", bundle: nil), forCellReuseIdentifier: cellID)
        tableView.allowsSelection = false
        tableView.isScrollEnabled = false
        tableView.afterEffect(cornerRadius: 10.0, borderWidth: 0.0, borderColor: .clear)
    }
    @IBAction func showMoreBtnPressed(_ sender: UIButton) {
        if let onTapShowMore = onTapShowMore {
            onTapShowMore(ratings)
        }
    }
}

// MARK: - UITableViewDatasource
extension CourseDetailRatingCell: UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
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

// MARK: - UITableViewDelegate
extension CourseDetailRatingCell: UITableViewDelegate {
    
}
