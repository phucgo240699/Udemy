//
//  SearchHeader.swift
//  Udemy
//
//  Created by Phúc Lý on 17/11/2020.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import UIKit

class SearchHeader: BaseViewXib {
    
    // Closure
    var onTextChange: ((String) -> Void)?
    var onTapReturnKey: ((String) -> Void)?
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func setUpViews() {
        setupUI()
    }
    
    func setupUI() {
        searchBar.delegate = self
    }
}

// MARK: UISearchBar Delegate
extension SearchHeader: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let onTextChange = onTextChange {
            onTextChange(searchText)
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let onTapReturnKey = onTapReturnKey, let text = searchBar.text {
            onTapReturnKey(text)
        }
    }
    
}
