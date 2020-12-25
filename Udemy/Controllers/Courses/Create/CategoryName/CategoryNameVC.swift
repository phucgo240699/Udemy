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
        tableView.register(UINib(nibName: "SimpleTableViewCell", bundle: nil), forCellReuseIdentifier: cellID)
        
        
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? SimpleTableViewCell else {
            return UITableViewCell()
        }
        cell.label?.text = categories[indexPath.row].name
        if let image = categories[indexPath.row].image {
            cell.imgView?.sd_setImage(with: URL(string: "\(Common.link.getCategoryThumbnail)/\(image)"), completed: nil)
        }
        return cell
    }
    
    
}

extension CategoryNameVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didChooseCategory(category: categories[indexPath.row])
        navigationController?.popViewController(animated: true)
    }
}
