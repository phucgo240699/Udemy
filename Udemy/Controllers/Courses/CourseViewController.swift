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

    // Components UI
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lbEmpty: UILabel!
    var addBarButton: UIBarButtonItem?
    var refreshControl: UIRefreshControl = UIRefreshControl()
    
    
    // Data
    var courses: [JoinedCourse] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addBarButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(CourseViewController.addLessonBarBtnPressed(_:)))
        navigationController?.navigationItem.title = "Courses"
        navigationItem.rightBarButtonItem = addBarButton
        
        setupUI()
        
        adaptData()
    }
    
    func setupUI() {
        navigationItem.title = "Courses"
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "MyCourseTableViewCell", bundle: nil), forCellReuseIdentifier: cellID)
        
        // refresh control
        refreshControl.addTarget(self, action: #selector(CourseViewController.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    @objc func addLessonBarBtnPressed(_ sender: UIBarButtonItem) {
        let createCourseVC = CreateCourseVC()
        navigationController?.pushViewController(createCourseVC, animated: true)
    }
    
    @objc func refresh(_ sender: UIRefreshControl) {
        refreshControl.endRefreshing()
        
        adaptData()
    }
    
    func adaptData() {
        RequestAPI.shared.fetchJoinedCourses(by: (UIApplication.shared.delegate as? AppDelegate)?.account._id) { (joinedCourses) in
            self.courses = joinedCourses

            self.handleEmptyData()
            
            self.tableView.reloadData()
        }
    }
    
    func handleEmptyData() {
        if self.courses.count == 0 {
            self.tableView.isHidden = true
            self.lbEmpty.isHidden = false
        }
        else {
            self.tableView.isHidden = false
            self.lbEmpty.isHidden = true
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
        
        cell.backgroundColor = .clear
        cell.setData(course: courses[indexPath.row])
        cell.accessoryType = .none
        
        return cell
        
    }
}

// MARK: - UITableViewDelegate
extension CourseViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let lessonVC = LessonViewController()
        lessonVC.idCourse = self.courses[indexPath.row].idCourse?._id
        self.navigationController?.pushViewController(lessonVC, animated: true)
        
    }
}
