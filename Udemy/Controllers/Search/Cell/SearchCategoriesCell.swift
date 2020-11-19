//
//  SearchCategoriesCell.swift
//  Udemy
//
//  Created by Phúc Lý on 19/11/2020.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import UIKit

fileprivate let cellID = "searchCategoriesCell"
class SearchCategoriesCell: UITableViewCell {
    
    // Closure
    var onTapCategory: ((Category) -> Void)?

    @IBOutlet weak var collectionView: UICollectionView!
    
    var categories: [Category] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
        
        RequestAPI.shared.fetchCategories { (categories) in
            self.categories = categories
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupUI() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: cellID)
    }
    
}

// MARK: - UICollectionViewDatasource, UICollectionViewDelegateFlowLayout
extension SearchCategoriesCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.height * 1.6, height: collectionView.bounds.height * 0.9)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as? CategoryCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.fillData(categories[indexPath.row])
        
        return cell
    }
    
    
}

// MARK: - UICollectionViewDelegate
extension SearchCategoriesCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let onTapCategory = onTapCategory {
            onTapCategory(categories[indexPath.row])
        }
    }
}
