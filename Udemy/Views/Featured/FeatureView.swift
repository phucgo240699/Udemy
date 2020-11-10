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
        for subVC in bannerPageViewController.subViewControllers {
            subVC.view.frame = CGRect(x: 0, y: 0, width: width, height: bannerHeight)
        }
        scrollView.addSubview(bannerPageViewController.view)
    }
    
    func initializeCollectionView(_ collectionView: inout UICollectionView?,  _ lbTitle: inout UILabel?, _ topAnchor: YAnchor, _ collectionViewHeight: CGFloat, _ tag: Int, _ cellIdentifier: String) {
        
        // Layout for collection view
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        // initialize
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        lbTitle = UILabel()
        guard let collectionView = collectionView, let lbTitle = lbTitle else {
            return
        }
        
        // Constraints
        lbTitle.addToViewByConstraints(parent: scrollView,
                                                         top: topAnchor,
                                                         bottom: nil,
                                                         leading: nil,
                                                         trailing: nil,
                                                         centerY: nil,
                                                         centerX: XAnchor(direction: scrollView.centerXAnchor, constant: 0),
                                                         width: width - 2 * margin,
                                                         height: titleHeight)
        collectionView.addToViewByConstraints(parent: scrollView,
                                              top: YAnchor(direction: lbTitle.bottomAnchor, constant: margin),
                                              bottom: nil,
                                              leading: nil,
                                              trailing: nil,
                                              centerY: nil,
                                              centerX: XAnchor(direction: scrollView.centerXAnchor, constant: 0),
                                              width: width - 2 * margin,
                                              height: collectionViewHeight)
        // Title
        lbTitle.text = titleCollectionViews[tag]
        lbTitle.textColor = Common.color.textColor
        lbTitle.font = UIFont(name: Common.fontName, size: titleHeight * 0.8)
        
        // Collection view
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
