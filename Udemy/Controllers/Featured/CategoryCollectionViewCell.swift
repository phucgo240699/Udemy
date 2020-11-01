//
//  CategoryCollectionViewCell.swift
//  Udemy
//
//  Created by Phúc Lý on 10/22/20.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage

class CategoryCollectionViewCell: UICollectionViewCell {
    
    var container: UIView?
    var thumbnailImgView: UIImageView?
    var titleLbl: UILabel?
    
    var margin: CGFloat = UIDevice.current.userInterfaceIdiom == .pad ? 20.0 : 10.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initializeComponents(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initializeComponents(frame: CGRect) {
        
        // Container
        container = UIView(frame: CGRect(x: margin, y: margin, width: frame.width - 2 * margin, height: frame.height - 2 * margin))
        guard let container = container else {
            return
        }
        self.addSubview(container)
        
        let containerWidth = container.bounds.width
        let containerHeight = container.bounds.height
        
        
        // Thumbnail
        thumbnailImgView = UIImageView(frame: container.bounds)
        
        // Title
        titleLbl = UILabel(frame: CGRect(x: 0, y: 0, width: containerWidth, height: containerHeight * 0.2))
        
        guard let thumbnailImgView = thumbnailImgView, let titleLbl = titleLbl else {
            return
        }
        
        // Font - Size - Color
        container.layer.cornerRadius = container.bounds.height * 0.05
        container.layer.masksToBounds = true
        thumbnailImgView.contentMode = .scaleAspectFill
        titleLbl.font = UIFont(name: Common.fontName, size: containerHeight * 0.15)
        titleLbl.font = UIFont.boldSystemFont(ofSize: containerHeight * 0.15)
        titleLbl.textColor = .white
        titleLbl.textAlignment = .center
        titleLbl.numberOfLines = 0
        
        container.addSubview(thumbnailImgView)
        container.addSubview(titleLbl)
        
        
        // Constraints
        titleLbl.translatesAutoresizingMaskIntoConstraints = false
        titleLbl.centerYAnchor.constraint(equalTo: container.centerYAnchor).isActive = true
        titleLbl.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
    }
    
    func fillData(_ category: Category) {
        // Thumbnail
        if let imageName = category.image {
            if let url = URL(string: "\(Common.link.getCategoryThumbnail)/\(imageName)") {
                self.thumbnailImgView?.sd_setImage(with: url, completed: nil)
            }
        }
        
        // Title
        if let title = category.name {
            titleLbl?.text = title
        }
    }
}
