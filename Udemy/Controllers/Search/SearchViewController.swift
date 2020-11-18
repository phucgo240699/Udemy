//
//  SearchViewController.swift
//  Udemy
//
//  Created by Phúc Lý on 17/11/2020.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import UIKit


fileprivate let cellID: String = "searchTBVCell"
fileprivate let headerHeight: CGFloat = 80.0

class SearchViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        enableTapToDismiss()
        
        setupUI()
    }
    
    func setupUI() {
        
        let header = SearchHeader(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: headerHeight))
        header.onTextChange = { text in
            print(text)
        }
        tableView.tableHeaderView = header
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "searchCell")
    }
}

// MARK: UITableViewDatasource
extension SearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath)
        
        cell.accessoryView = .none
        
        return  cell
    }
    
    
}

// MARK: UITableViewDelegate
extension SearchViewController: UITableViewDelegate {
    
}
