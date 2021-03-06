//
//  CourseDetailOperationCell.swift
//  Udemy
//
//  Created by Phúc Lý on 15/11/2020.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import UIKit
import Cosmos

class CourseDetailOperationCell: UITableViewCell {
    
    // Closure
    var onTapJoinCourseBtn: (() -> Void)?
    var onTapAddToCartBtn: (() -> Void)?
    var onTapWriteReviewBtn: (() -> Void)?
    
    // Components
    @IBOutlet weak var joinButton: UIButton!
    @IBOutlet weak var addCartButton: UIButton!
    @IBOutlet weak var ratingCosmos: CosmosView!
    
    var isJoinedCourse: Bool? {
        didSet {
            if isJoinedCourse == false {
                UIView.animate(withDuration: 0.5) {
                    self.joinButton.backgroundColor = Common.color.blue
                    self.joinButton.isEnabled = true
                }
            }
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupUI() {
        //-- Join Button
        joinButton.afterEffect(cornerRadius: 5.0, borderWidth: 1.0, borderColor: Common.color.blue)
        joinButton.dropShadow(color: Common.color.textColor, opacity: 0.5, offSet: CGSize(width: 2, height: 3), radius: 3.0, scale: false)
        
        //-- Add to cart Button
        addCartButton.afterEffect(cornerRadius: 5.0, borderWidth: 1.0, borderColor: Common.color.blue)
        addCartButton.dropShadow(color: Common.color.textColor, opacity: 0.5, offSet: CGSize(width: 2, height: 3), radius: 3.0, scale: false)
    }
    
    func setData(course: Course?) {
        if let course = course {
            if let ranking = course.ranking {
                ratingCosmos.rating = Double(ranking)
            }
        }
    }
    
    
    @IBAction func joinButtonPressed(_ sender: UIButton) {
        if let onTapJoinCourseBtn = onTapJoinCourseBtn {
            onTapJoinCourseBtn()
        }
    }
    @IBAction func addCartButtonPressed(_ sender: UIButton) {
        if let onTapJoinAddCartBtn = onTapAddToCartBtn {
            onTapJoinAddCartBtn()
        }
    }
    @IBAction func writeReviewButtonPressed(_ sender: UIButton) {
        if let onTapWriteReviewBtn = onTapWriteReviewBtn {
            onTapWriteReviewBtn()
        }
    }
    
}
