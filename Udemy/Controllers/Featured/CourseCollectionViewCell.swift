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
import SDWebImage

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
    
    func fillData(_ course: Course) {
        
        // Thumbnail
        if let imageName = course.image {
            if let url = URL(string: "\(Common.link.getCourseThumbnail)/\(imageName)") {
                self.thumbnailImgView?.sd_setImage(with: url)
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
