//
//  CourseTableViewCell.swift
//  Udemy
//
//  Created by Phúc Lý on 16/11/2020.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import UIKit
import SDWebImage

class CourseTableViewCell: UITableViewCell {

    @IBOutlet weak var imgViewThumbnail: UIImageView!
    @IBOutlet weak var lbName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(course: JoinedCourse) {
        if let imageName = course.idCourse.image {
            imgViewThumbnail.sd_setImage(with: URL(string: "\(Common.link.getCourseThumbnail)/\(imageName)"), completed: nil)
        }
        lbName.text = course.idCourse.name
    }
}
