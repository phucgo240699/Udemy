//
//  SearchResultViewController.swift
//  Udemy
//
//  Created by Phúc Lý on 18/11/2020.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import UIKit

fileprivate let cellID: String = "searchResultTBVCell"
fileprivate let cellHeight: CGFloat = 140.0

class SearchResultViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lbNotFound: UILabel!
    
    var courses: [RegularCourse] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = false

        setupUI()
    }
    
    func setupUI() {
        tableView.separatorStyle = .none
        
        if courses.count > 0 {
            tableView.isHidden = false
            lbNotFound.isHidden = true
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: "CourseTableViewCell", bundle: nil), forCellReuseIdentifier: cellID)
        }
        else {
            tableView.isHidden = true
            lbNotFound.isHidden = false
        }
        
    }
    
}

// MARK: - UITableViewDatasource
extension SearchResultViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? CourseTableViewCell else {
            return UITableViewCell()
        }
        
        cell.setData(course: courses[indexPath.row])
        cell.accessoryType = .none
        
        return cell
        
    }
}

// MARK: - UITableViewDelegate
extension SearchResultViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let courseDetailVC = CourseDetailVC()
        courseDetailVC.course = courses[indexPath.row].getCourse()
        navigationController?.pushViewController(courseDetailVC, animated: true)
    }
}
