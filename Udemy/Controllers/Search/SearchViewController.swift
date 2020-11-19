//
//  SearchViewController.swift
//  Udemy
//
//  Created by Phúc Lý on 17/11/2020.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import UIKit


fileprivate let headerHeight: CGFloat = 80.0

enum SearchCellType: String {
    case Suggestion = "searchCell"
    case Category = "categoryCell"
}

class SearchViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var header: SearchHeader?
    let cellTypes: [SearchCellType] = [ .Suggestion ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        enableTapToDismiss()
        
        setupUI()
    }
    
    func setupUI() {
        
        header = SearchHeader(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: headerHeight))
        header?.onTapReturnKey = { text in
            self.searchCourses(by: text)
        }
        tableView.tableHeaderView = header
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "SearchSuggestionCell", bundle: nil), forCellReuseIdentifier: SearchCellType.Suggestion.rawValue)
        
    }
}

// MARK: UITableViewDatasource
extension SearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch cellTypes[indexPath.row] {
        case .Suggestion:
            return 170.0
        default:
            return 300.0
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellTypes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let type = cellTypes[indexPath.row]
        switch type {
        case .Suggestion:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: type.rawValue , for: indexPath) as? SearchSuggestionCell else {
                return UITableViewCell()
            }
            
            cell.onTapTagCell = { text in
                self.header?.searchBar.text = text
                self.header?.searchBar.becomeFirstResponder()
            }
            
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: type.rawValue , for: indexPath)
            return cell
        }
    }
    
    
}

// MARK: UITableViewDelegate
extension SearchViewController: UITableViewDelegate {
    
}
