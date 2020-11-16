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
    
    var courses: [JoinedCourse] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        fetchCourses(by: (UIApplication.shared.delegate as? AppDelegate)?.account._id)
    }
    
    func setupUI() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "CourseTableViewCell", bundle: nil), forCellReuseIdentifier: cellID)
    }
}

// MARK: - UITableViewDatasource
extension CourseViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? CourseTableViewCell else {
            return UITableViewCell()
        }
        
        cell.setData(course: courses[indexPath.row])
        
        return cell
        
    }
}

// MARK: - UITableViewDelegate
extension CourseViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Did select")
    }
}
