//
//  CourseCell.swift
//  Udemy
//
//  Created by Phúc Lý on 10/22/20.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import UIKit
import Cosmos

extension CourseCollectionViewCell {
    func initializeContainer() {
        container = UIView()
        guard let container = container else {
            return
        }
        self.addSubview(container)
        
        container.addToViewByConstraints(parent: self,
            top: YAnchor(direction: self.topAnchor, constant: margin),
            bottom: YAnchor(direction: self.bottomAnchor, constant: -margin),
            leading: XAnchor(direction: self.leadingAnchor, constant: margin),
            trailing: XAnchor(direction: self.trailingAnchor, constant: -margin),
            centerY: nil,
            centerX: nil,
            width: nil,
            height: nil)
        
        container.layer.cornerRadius = containerHeight * 0.025
        container.layer.masksToBounds = true
    }
    
    func initializeThumbnail() {
        thumbnailImgView = UIImageView()
        guard let container = container, let thumbnailImgView = thumbnailImgView else {
            return
        }
        
        thumbnailImgView.addToViewByConstraints(parent: container,
            top: YAnchor(direction: container.topAnchor, constant: 0),
            bottom: nil,
            leading: XAnchor(direction: container.leadingAnchor, constant: 0),
            trailing: XAnchor(direction: container.trailingAnchor, constant: 0),
            centerY: nil,
            centerX: nil,
            width: nil,
            height: containerHeight * 0.3)
        
        thumbnailImgView.contentMode = .scaleAspectFit
    }
    
    func initializeTitle() {
        titleLbl = UILabel()
        guard let container = container, let thumbnailImgView = thumbnailImgView, let titleLbl = titleLbl else {
            return
        }
//        titleLbl.frame.size.height = containerHeight * 0.1
        container.addSubview(titleLbl)
        
        titleLbl.translatesAutoresizingMaskIntoConstraints = false
        titleLbl.topAnchor.constraint(equalTo: thumbnailImgView.bottomAnchor, constant: containerHeight * 0.05).isActive = true
        titleLbl.leadingAnchor.constraint(equalTo: container.leadingAnchor).isActive = true
        titleLbl.trailingAnchor.constraint(equalTo: container.trailingAnchor).isActive = true
        let heightConstraint = titleLbl.heightAnchor.constraint(lessThanOrEqualToConstant: containerHeight * 0.35)
//        heightConstraint.priority = UILayoutPriority(rawValue: 900)
        heightConstraint.isActive = true
        
        titleLbl.font = UIFont(name: Common.fontName, size: containerHeight * 0.06)
        titleLbl.numberOfLines = 0
    }
    
    func initializeRating() {
        guard let container = container, let titleLbl = titleLbl else {
            return
        }
        
        // Rating Star: 0.05
        // 1. setting rating
        var setting = CosmosSettings()
        setting.starSize = Double(containerHeight * 0.08)
        setting.updateOnTouch = false
        if let font = UIFont(name: Common.fontName, size: containerHeight * 0.04) {
            setting.textFont = font
        }
        // 2. initialize
        ratingStar = CosmosView(settings: setting)
        guard let ratingStar = ratingStar else {
            return
        }
        
        container.addSubview(ratingStar)
        
        ratingStar.addToViewByConstraints(parent: container,
            top: YAnchor(direction: titleLbl.bottomAnchor, constant: containerHeight * 0.02),
            bottom: nil,
            leading: XAnchor(direction: container.leadingAnchor, constant: 0),
            trailing: XAnchor(direction: container.trailingAnchor, constant: 0),
            centerY: nil,
            centerX: nil,
            width: nil,
            height: containerHeight * 0.08)
        
    }
    
    func initializePriceAfterDiscount() {
        priceAfterDiscountLbl = UILabel()
        guard let container = container, let ratingStar = ratingStar, let priceAfterDiscountLbl = priceAfterDiscountLbl else {
            return
        }
        
        priceAfterDiscountLbl.addToViewByConstraints(parent: container,
            top: YAnchor(direction: ratingStar.bottomAnchor, constant: containerHeight * 0.02),
            bottom: nil,
            leading: XAnchor(direction: container.leadingAnchor, constant: 0),
            trailing: XAnchor(direction: container.trailingAnchor, constant: 0),
            centerY: nil,
            centerX: nil,
            width: nil,
            height: containerHeight * 0.08)
        
        priceAfterDiscountLbl.font = UIFont(name: Common.fontName, size: containerHeight * 0.08)
        priceAfterDiscountLbl.textColor = Common.color.lightRed
    }
    
    
    func initializeOriginalPrice() {
        originalPriceLbl = UILabel()
        guard let container = container, let priceAfterDiscountLbl = priceAfterDiscountLbl, let originalPriceLbl = originalPriceLbl else {
            return
        }
        
        originalPriceLbl.addToViewByConstraints(parent: container,
            top: YAnchor(direction: priceAfterDiscountLbl.bottomAnchor, constant: containerHeight * 0.02),
            bottom: nil,
            leading: XAnchor(direction: container.leadingAnchor, constant: 0),
            trailing: XAnchor(direction: container.trailingAnchor, constant: 0),
            centerY: nil,
            centerX: nil,
            width: nil,
            height: containerHeight * 0.04)
        
        originalPriceLbl.font = UIFont(name: Common.fontName, size: containerHeight * 0.04)
        originalPriceLbl.textColor = .systemGray
    }
    
    
}
