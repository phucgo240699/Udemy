//
//  CourseViewController.swift
//  Udemy
//
//  Created by Phúc Lý on 16/11/2020.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import UIKit

fileprivate let cellID: String = "courseTBVCell"

class CourseViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var refreshControl: UIRefreshControl = UIRefreshControl()
    var courses: [JoinedCourse] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationItem.title = "Courses"
        
        setupUI()
        
        RequestAPI.shared.fetchJoinedCourses(by: (UIApplication.shared.delegate as? AppDelegate)?.account._id) { (joinedCourses) in
            self.courses = joinedCourses
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func setupUI() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "MyCourseTableViewCell", bundle: nil), forCellReuseIdentifier: cellID)
        
        // refresh control
        refreshControl.addTarget(self, action: #selector(CourseViewController.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    @objc func refresh(_ sender: UIRefreshControl) {
        refreshControl.endRefreshing()
        
        RequestAPI.shared.fetchJoinedCourses(by: (UIApplication.shared.delegate as? AppDelegate)?.account._id) { (joinedCourses) in
            self.courses = joinedCourses
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
    }
}

// MARK: - UITableViewDatasource
extension CourseViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120.0//UITableView.automaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? MyCourseTableViewCell else {
            return UITableViewCell()
        }
        
        cell.setData(course: courses[indexPath.row])
        cell.accessoryType = .none
        
        return cell
        
    }
}

// MARK: - UITableViewDelegate
extension CourseViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Did select")
    }
}
