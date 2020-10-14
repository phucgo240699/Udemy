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
        
        titleLabel = UILabel()
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        guard let collectionView = collectionView, let titleLabel = titleLabel else {
            return
        }
        titleLabel.addToViewByConstraints(parent: container,
                                          top: YAnchor(direction: container.topAnchor, constant: marginSpace),
                                          bottom: nil,
                                          leading: XAnchor(direction: container.leadingAnchor, constant: marginSpace),
                                          trailing: XAnchor(direction: container.trailingAnchor, constant: -marginSpace),
                                          centerY: nil,
                                          centerX: nil,
                                          width: nil,
                                          height: headerHeight)
        collectionView.addToViewByConstraints(parent: container,
                                              top: YAnchor(direction: titleLabel.bottomAnchor, constant: 0),
                                              bottom: YAnchor(direction: container.bottomAnchor, constant: 0),
                                          leading: XAnchor(direction: container.leadingAnchor, constant: 0),
                                          trailing: XAnchor(direction: container.trailingAnchor, constant: 0),
                                          centerY: nil,
                                          centerX: nil,
                                          width: nil,
                                          height: nil)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "courseCell")
        
        collectionView.layer.cornerRadius = height * 0.2
        collectionView.backgroundColor = .systemBackground
        
        titleLabel.textColor = Common.color.textColor
        titleLabel.textAlignment = .natural
        titleLabel.font = UIFont(name: Common.fontName, size: headerHeight * 0.6)
            
    }
    
}
