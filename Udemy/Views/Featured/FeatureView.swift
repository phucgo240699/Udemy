//
//  FeatureView.swift
//  Udemy
//
//  Created by Phúc Lý on 10/20/20.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import UIKit

extension FeatureViewController {
    func setUpBanner() {
        bannerPageViewController.view.frame = CGRect(x: 0, y: 0, width: width, height: bannerHeight)
        
        scrollView.addSubview(bannerPageViewController.view)
    }
    
    func initializeCollectionView(_ collectionView: inout UICollectionView?, _ topAnchor: YAnchor, _ collectionViewHeight: CGFloat, _ tag: Int, _ cellIdentifier: String) {
        
        // Layout for collection view
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        // initialize
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        guard let collectionView = collectionView else {
            return
        }
        
        // Constraints
        collectionView.addToViewByConstraints(parent: scrollView,
                                                         top: topAnchor,
                                                         bottom: nil,
                                                         leading: nil,
                                                         trailing: nil,
                                                         centerY: nil,
                                                         centerX: XAnchor(direction: scrollView.centerXAnchor, constant: 0),
                                                         width: width - 2 * margin,
                                                         height: collectionViewHeight)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        if tag == 3 {
            collectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier) // Category
        }
        else {
            collectionView.register(CourseCollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        }
        collectionView.tag = tag
        collectionView.layer.cornerRadius = collectionViewHeight * 0.05
        collectionView.backgroundColor = Common.color.backgroundColor
    }
}
