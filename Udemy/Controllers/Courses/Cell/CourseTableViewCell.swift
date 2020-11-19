//
//  CourseTableViewCell.swift
//  Udemy
//
//  Created by Phúc Lý on 19/11/2020.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import UIKit
import Cosmos


class CourseTableViewCell: UITableViewCell {

    @IBOutlet weak var container: UIView!
    @IBOutlet weak var imgViewThumbnail: UIImageView!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbGoal: UILabel!
    @IBOutlet weak var cosmosViewRating: CosmosView!
    @IBOutlet weak var lbPrice: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupUI() {
        container.afterEffect(cornerRadius: 5.0, borderWidth: 0.0, borderColor: .clear)
    }
    
    func setData(course: RegularCourse) {
        if let imageName = course.image {
            imgViewThumbnail.sd_setImage(with: URL(string: "\(Common.link.getCourseThumbnail)/\(imageName)"), completed: nil)
        }
        
        lbName.text = course.name
        lbGoal.text = course.goal
        cosmosViewRating.rating = Double(course.ranking ?? 0)
        lbPrice.text = String(course.discountPrice ?? 0)
    }
}
