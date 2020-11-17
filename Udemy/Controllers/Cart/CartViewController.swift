//
//  CartViewController.swift
//  Udemy
//
//  Created by Phúc Lý on 17/11/2020.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import UIKit

fileprivate let cellID: String = "orderedCourseTBVCell"
fileprivate let cellHeight: CGFloat = 200.0

class CartViewController: UIViewController {
    

    @IBOutlet weak var tableView: UITableView!
    
    var refreshControl: UIRefreshControl = UIRefreshControl()
    
    var courses: [CoursesInCart] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationItem.title = "Cart"
        
        setupUI()
        
        guard let appDelegate = (UIApplication.shared.delegate as? AppDelegate) else {
            return
        }
        for courseId in appDelegate.cart.courseIds {
            fetchCourseById(courseId)
        }
    }

    func setupUI() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "OrderedCourseTableViewCell", bundle: nil), forCellReuseIdentifier: cellID)
        
        // Refresh
        refreshControl.addTarget(self, action: #selector(CartViewController.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
        
    }
    
    @objc func refresh(_ sender: UIRefreshControl) {
        refreshControl.endRefreshing()
        
        guard let appDelegate = (UIApplication.shared.delegate as? AppDelegate) else {
            return
        }
        
        courses = []
        
        for courseId in appDelegate.cart.courseIds {
            fetchCourseById(courseId)
        }
    }
}


// MARK: UITableViewDatasource
extension CartViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? OrderedCourseTableViewCell else {
            return UITableViewCell()
        }
        cell.onTapPaymentBtn = {
            // TODO: Pay
        }
        cell.setData(course: courses[indexPath.row])
        
        return cell
    }
    
    
}

// MARK: UITableViewDelegate
extension CartViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Did select")
    }
}
