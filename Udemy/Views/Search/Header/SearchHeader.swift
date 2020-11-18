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
}
