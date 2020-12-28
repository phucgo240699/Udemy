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
    var rightBarBtn: UIBarButtonItem?
    
    var refreshControl: UIRefreshControl = UIRefreshControl()
    
    
    // Data
    var courses: [JoinedCourse] = []
    var displayCourses: [JoinedCourse] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.enableTapToDismiss()
        
        // Title
        navigationItem.title = "Joined Courses"
        
        // Left
        rightBarBtn = UIBarButtonItem(title: "My Course", style: .plain, target: self, action: #selector(CourseViewController.rightBarBtnPressed(_:)))
        navigationItem.rightBarButtonItem = rightBarBtn
        
        
        setupUI()
        
        adaptData()
    }
    
    func setupUI() {
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "JoinedCourseTableViewCell", bundle: nil), forCellReuseIdentifier: cellID)
        
        // refresh control
        refreshControl.addTarget(self, action: #selector(CourseViewController.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    @objc func rightBarBtnPressed(_ sender: UIBarButtonItem) {
        let myCoursesVC = MyCourseVC()
        navigationController?.pushViewController(myCoursesVC, animated: true)
    }
    
    @objc func refresh(_ sender: UIRefreshControl) {
        refreshControl.endRefreshing()
        
        adaptData()
    }
    
    func adaptData() {
        RequestAPI.shared.fetchJoinedCourses(by: (UIApplication.shared.delegate as? AppDelegate)?.account._id) { (joinedCourses) in
            self.courses = joinedCourses
            self.displayCourses = joinedCourses

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
    
    // -- Header
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let searchBar = UISearchBar()
        searchBar.delegate = self
        return searchBar
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120.0//UITableView.automaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayCourses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? JoinedCourseTableViewCell else {
            return UITableViewCell()
        }
        
        cell.backgroundColor = .clear
        cell.setData(course: displayCourses[indexPath.row])
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


// MARK: - Search Delegate
extension CourseViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.isEmptyOrSpacing() {
            displayCourses = courses
        }
        else {
            displayCourses = courses.filter({ (course) -> Bool in
                return course.idCourse?.name?.lowercased().contains(searchText.lowercased()) ?? false
            })
        }
        
        UIView.animate(withDuration: 0.5) {
            self.tableView.reloadData()
        }
    }
}
