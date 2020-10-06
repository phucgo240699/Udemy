//
//  FeatureCell.swift
//  Udemy
//
//  Created by Phúc Lý on 10/6/20.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import UIKit

extension FeatureTableViewCell {
    
    func initializeContainer() {
        container = UIView()
        guard let container = container else {
            return
        }
        self.addSubview(container)
        
        container.translatesAutoresizingMaskIntoConstraints = false
        
        container.topAnchor.constraint(equalTo: self.topAnchor, constant: marginSpace).isActive = true
        container.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -marginSpace).isActive = true
        container.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: marginSpace).isActive = true
        container.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -marginSpace).isActive = true
        
        container.layer.cornerRadius = height * 0.2
        container.backgroundColor = .systemBackground
    }
    
    func initializeCollectionView() {
        guard let container = container else {
            return
        }
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: container.bounds, collectionViewLayout: layout)
        
        guard let collectionView = collectionView else {
            return
        }
        collectionView.pin(to: container)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "courseCell")
        
        collectionView.backgroundColor = .none
            
    }
    
}
