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
    var searchString: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addBarButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(CourseViewController.addCourseBarBtnPressed(_:)))
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
    
    @objc func addCourseBarBtnPressed(_ sender: UIBarButtonItem) {
        let createCourseVC = CreateCourseVC()
        createCourseVC.delegate = self
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
        if let searchString = searchString {
            if searchString.isEmptyOrSpacing() == false {
                return courses.filter { (course) -> Bool in
                    return (course.idCourse?.name?.contains(searchString) ?? false)
                }.count
            }
        }
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


// MARK: - CreateCourseVCDelegate
extension CourseViewController: CreateCourseVCDelegate {
    func didCreateSuccessfully() {
        
        // Notify
        self.notificate(UIImage(named: Common.imageName.done), "Created Successfully", "")
        
        adaptData()
        
    }
}


// MARK: - Search Delegate
extension CourseViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchString = searchText
        
        UIView.animate(withDuration: 0.5) {
            self.tableView.reloadData()
        }
    }
}
