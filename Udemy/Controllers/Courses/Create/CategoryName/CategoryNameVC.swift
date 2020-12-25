//
//  CategoryNameVC.swift
//  Udemy
//
//  Created by Phúc Lý on 25/12/2020.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import UIKit

fileprivate let cellID: String = "categoryCell"

protocol CategoryNameVCDelegate: class {
    func didChooseCategory(category: Category)
}

class CategoryNameVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var refreshControl: UIRefreshControl = UIRefreshControl()
    
    var categories: [Category] = []
    var choseCategory: Category?
    
    weak var delegate: CategoryNameVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
        adaptData()
    }

    private func setupUI() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        
        
        // refresh control
        refreshControl.addTarget(self, action: #selector(CourseViewController.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    @objc func refresh(_ sender: UIRefreshControl) {
        refreshControl.endRefreshing()
        
        adaptData()
    }
    
    func adaptData() {
        RequestAPI.shared.fetchCategories { (categories) in
            self.categories = categories
            
            self.tableView.reloadData()
        }
    }
}

extension CategoryNameVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        cell.textLabel?.text = categories[indexPath.row].name
        return cell
    }
    
    
}

extension CategoryNameVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didChooseCategory(category: categories[indexPath.row])
        navigationController?.popViewController(animated: true)
    }
}
