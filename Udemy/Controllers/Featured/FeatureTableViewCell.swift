//
//  FeatureTableViewCell.swift
//  Udemy
//
//  Created by Phúc Lý on 10/6/20.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import UIKit

class FeatureTableViewCell: UITableViewCell {
    
    var width:CGFloat {
        get {
            return self.bounds.width
        }
    }
    var height: CGFloat {
        get {
            return self.bounds.height
        }
    }
    var headerHeight: CGFloat {
        get {
            return height * 0.2
        }
    }
    var marginSpace: CGFloat = UIDevice.current.userInterfaceIdiom == .phone ? 10.0 : 20.0
    
    
    var container: UIView?
    var collectionView: UICollectionView?
    var listCourses: [Course] = []
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .none
        
        initializeContainer()
        initializeCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}


// MARK: - CollectionViewDelegates
extension FeatureTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listCourses.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "courseCell", for: indexPath) 
        
        return cell
        
    }
    
    
}
