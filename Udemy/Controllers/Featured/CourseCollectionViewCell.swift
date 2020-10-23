//
//  CourseCollectionViewCell.swift
//  Udemy
//
//  Created by Phúc Lý on 10/21/20.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import UIKit
import Cosmos
import Alamofire

class CourseCollectionViewCell: UICollectionViewCell {
    
    // Variables
    var width: CGFloat {
        get {
            return self.bounds.width
        }
    }
    var height: CGFloat {
        get {
            return self.bounds.height
        }
    }
    var margin: CGFloat = UIDevice.current.userInterfaceIdiom == .pad ? 20.0 : 10.0
    var containerHeight: CGFloat {
        get {
            return height - 2 * margin
        }
    }
    
    
    // Components
    var container: UIView?
    var thumbnailImgView: UIImageView?
    var titleLbl: UILabel?
    var ratingStar: CosmosView?
    var priceAfterDiscountLbl: UILabel?
    var originalPriceLbl: UILabel?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initializeContainer()
        initializeThumbnail()
        initializeTitle()
        initializeRating()
        initializePriceAfterDiscount()
        initializeOriginalPrice()
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
        
        // Thumbnail: 0.4
        thumbnailImgView = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: height * 0.4))
        
        // Title: 0.25
        titleLbl = UILabel(frame: CGRect(x: 0, y: height * 0.4, width: width, height: height * 0.25))
        
        // Rating Star: 0.05
        // 1. setting rating
        var setting = CosmosSettings()
        setting.starSize = Double(height * 0.05)
        setting.updateOnTouch = false
        if let font = UIFont(name: Common.fontName, size: height * 0.05) {
            setting.textFont = font
        }
        // 2. initialize
        ratingStar = CosmosView(frame: CGRect(x: 0, y: height * 0.65, width: width, height: height * 0.05), settings: setting)
        
        
        // Discount Price: 0.1
        priceAfterDiscountLbl = UILabel(frame: CGRect(x: 0, y: height * 0.7, width: width, height: height * 0.1))
        
        // Original Price: 0.1
        originalPriceLbl = UILabel(frame: CGRect(x: 0, y: height * 0.8, width: width, height: height * 0.1))
        
        
        guard let thumbnailImgView = thumbnailImgView, let titleLbl = titleLbl, let ratingStar = ratingStar, let discountLbl = priceAfterDiscountLbl, let originalLbl = originalPriceLbl else {
            return
        }
        
        // Font - Size - Color
        container.layer.cornerRadius = container.bounds.height * 0.05
        container.layer.masksToBounds = true
        
        thumbnailImgView.contentMode = .scaleAspectFit
        
        titleLbl.font = UIFont(name: Common.fontName, size: height * 0.08)
        discountLbl.font = UIFont(name: Common.fontName, size: height * 0.1)
        originalLbl.font = UIFont(name: Common.fontName, size: height * 0.05)
        
        titleLbl.numberOfLines = 0
        discountLbl.textColor = Common.color.lightRed
        originalLbl.textColor = .systemGray
        
        container.addSubview(thumbnailImgView)
        container.addSubview(titleLbl)
        container.addSubview(ratingStar)
        container.addSubview(discountLbl)
        container.addSubview(originalLbl)
        
        
    }
    
    func fillData(_ course: Course) {
        
        // Thumbnail
        if let imageName = course.image {
            if let url = URL(string: "\(Common.link.getCourseThumbnail)/\(imageName)") {
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
        if let title = course.name {
            titleLbl?.text = title
        }
        
        // Rating
        if let totalVote = course.vote?.totalVote, let ranking = course.ranking {
            ratingStar?.rating = Double(ranking)
            ratingStar?.text = "\(totalVote)"
        }
        
        // Price
        if let originalPrice = course.price {
            originalPriceLbl?.text = String(originalPrice)
            if let discount = course.discount {
                let discountPercent = Double(discount) / 100.0
                priceAfterDiscountLbl?.text = String(Int(Double(originalPrice) * (1.0 - discountPercent)))
            }
        }
    }
    
}
