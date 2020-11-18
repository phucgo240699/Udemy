//
//  BannerInfoCell.swift
//  Udemy
//
//  Created by Phúc Lý on 15/11/2020.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import UIKit
import SDWebImage

class CourseDetailBannerInfoCell: UITableViewCell {
    @IBOutlet weak var imgViewBanner: UIImageView!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbGoal: UILabel!
    @IBOutlet weak var lbDiscountPrice: UILabel!
    @IBOutlet weak var lbOriginalPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(course: Course?) {
        if let course = course {
            let formatter = NumberFormatter()
            formatter.numberStyle = .currency
            
            if let imageName = course.image {
                imgViewBanner.sd_setImage(with: URL(string: "\(Common.link.getCourseThumbnail)/\(imageName)"), completed: nil)
            }
            lbName.text = course.name
            lbGoal.text = course.goal
            
            lbDiscountPrice.text = formatter.string(from: NSNumber(value: (course.discountPrice ?? 0)))
            lbOriginalPrice.text = formatter.string(from: NSNumber(value: (course.price ?? 0)))
        }
        
    }
    
}
