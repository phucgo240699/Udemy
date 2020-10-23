//
//  CategoryCollectionViewCell.swift
//  Udemy
//
//  Created by Phúc Lý on 10/22/20.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import UIKit
import Alamofire

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
        
        let width = container.bounds.width
        let height = container.bounds.height
        
        
        // Thumbnail
        thumbnailImgView = UIImageView(frame: container.bounds)
        
        // Title
        titleLbl = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: height * 0.2))
        
        guard let thumbnailImgView = thumbnailImgView, let titleLbl = titleLbl else {
            return
        }
        
        // Font - Size - Color
        container.layer.cornerRadius = container.bounds.height * 0.05
        container.layer.masksToBounds = true
        
        thumbnailImgView.contentMode = .scaleAspectFill
        
        titleLbl.center = container.center
        titleLbl.font = UIFont(name: Common.fontName, size: height * 0.2)
        titleLbl.font = UIFont.boldSystemFont(ofSize: height * 0.2)
        titleLbl.textColor = .white
        titleLbl.textAlignment = .center
        
        container.addSubview(thumbnailImgView)
        container.addSubview(titleLbl)
    }
    
    func fillData(_ category: Category) {
        // Thumbnail
        if let imageName = category.image {
            if let url = URL(string: "\(Common.link.getCategoryThumbnail)/\(imageName)") {
                AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).response {
                        response in
                    
                    guard let data = response.data else {
                        return
                    }
                    guard let image = UIImage(data: data) else {
                        return
                    }
                    self.thumbnailImgView?.image = image
                }
            }
        }
        
        // Title
        if let title = category.name {
            titleLbl?.text = title
        }
    }
}
