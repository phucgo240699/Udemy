//
//  MyCourseVC.swift
//  Udemy
//
//  Created by Phúc Lý on 28/12/2020.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import UIKit
import SwipeCellKit

fileprivate let cellID = "myCourseTBVCell"

class MyCourseVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lbEmpty: UILabel!
    var addBarButton: UIBarButtonItem?
    
    var refreshControl: UIRefreshControl = UIRefreshControl()
    
    var courses: [Course] = []
    var displayCourses: [Course] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        adaptData()
    }
    
    private func setupUI() {
        
        self.enableTapToDismiss()
        
        // Title
        navigationItem.title = "My Courses"
        
        // Right
        addBarButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(MyCourseVC.addCourseBarBtnPressed(_:)))
        navigationItem.rightBarButtonItem = addBarButton
        
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "MyCourseTBVCell", bundle: nil), forCellReuseIdentifier: cellID)
        
        
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
    
    func adaptData() {
        guard let appDelegate = (UIApplication.shared.delegate as? AppDelegate) else {
            return
        }
        RequestAPI.shared.fetchMyCourses(by: appDelegate.account._id) { (courses) in
            self.courses = courses
            self.displayCourses = courses
            self.handleEmptyData()
            self.tableView.reloadData()
        }
    }
}


// MARK: - UITableViewDataSource
extension MyCourseVC: UITableViewDataSource {
    
    // -- Header
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let searchBar = UISearchBar()
        searchBar.delegate = self
        return searchBar
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayCourses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? MyCourseTBVCell else {
            return UITableViewCell()
        }
        
        cell.delegate = self
        cell.setData(course: displayCourses[indexPath.row])
        
        return cell
    }
    
    
}


// MARK: - SwipeTableViewCellDelegate
extension MyCourseVC: SwipeTableViewCellDelegate {
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            RequestAPI.shared.deleteCourse(by: self.courses[indexPath.row]._id) {
                self.courses.remove(at: indexPath.row)
                
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        }
        let editAction = SwipeAction(style: .default, title: "Edit") { (action, indexPath) in
            let updateCourseVC = CreateCourseVC()
            let course = self.courses[indexPath.row]
            updateCourseVC.navigationItem.title = "Update"
            updateCourseVC.isEditForm = true
            updateCourseVC.updateCourse = course
            self.navigationController?.pushViewController(updateCourseVC, animated: true)
        }
        
        // customize the action appearance
        deleteAction.image = UIImage(named: Common.imageName.delete)
        editAction.image = UIImage(named: Common.imageName.edit)
        
        return [deleteAction, editAction]
    }
    
    
}


// MARK: - UITableViewDelegate
extension MyCourseVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let lessonVC = LessonViewController()
        lessonVC.idCourse = self.courses[indexPath.row]._id
        self.navigationController?.pushViewController(lessonVC, animated: true)
        
    }
}


// MARK: - CreateCourseVCDelegate
extension MyCourseVC: CreateCourseVCDelegate {
    func didUpdateSuccessfully() {
        adaptData()
    }
    
    func didCreateSuccessfully() {
        
        // Notify
        self.notificate(UIImage(named: Common.imageName.done), "Created Successfully", "")
        
        adaptData()
        
    }
}

// MARK: - Search Delegate
extension MyCourseVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.isEmptyOrSpacing() {
            displayCourses = courses
        }
        else {
            displayCourses = courses.filter({ (course) -> Bool in
                return course.name?.lowercased().contains(searchText.lowercased()) ?? false
            })
        }
        
        UIView.animate(withDuration: 0.5) {
            self.tableView.reloadData()
        }
    }
}
