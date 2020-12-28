//
//  MyCourseTBVCell.swift
//  Udemy
//
//  Created by Phúc Lý on 28/12/2020.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import UIKit
import Cosmos
import SwipeCellKit

class MyCourseTBVCell: SwipeTableViewCell {
    
    @IBOutlet weak var container: UIView!
    
    @IBOutlet weak var imgThumbnail: UIImageView!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var lbPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    private func setupUI() {
        container.afterEffect(cornerRadius: 10, borderWidth: 0, borderColor: .clear)
        container.dropShadow(color: .lightGray, opacity: 0.3, offSet: CGSize(width: 5.0, height: 5.0), radius: 5.0, scale: false)
    }
    
    func setData(course: Course) {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        
        if let thumbnail = course.image {
            imgThumbnail.sd_setImage(with: URL(string: "\(Common.link.getCourseThumbnail)/\(thumbnail)"), completed: nil)
        }
        
        lbName.text = course.name
        
        // Rating
        if let totalVote = course.vote?.totalVote, let ranking = course.ranking {
            ratingView.rating = Double(ranking)
            ratingView.text = "\(totalVote)"
        }
        
        // Price
        if let originalPrice = course.price {
            if let discount = course.discount {
                let discountPercent = Double(discount) / 100.0
                lbPrice.text = formatter.string(from: Int(Double(originalPrice) * (1.0 - discountPercent)) as NSNumber)
            }
        }
    }
    
}
