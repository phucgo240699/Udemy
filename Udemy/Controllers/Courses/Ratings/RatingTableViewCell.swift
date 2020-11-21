//
//  RatingTableViewCell.swift
//  Udemy
//
//  Created by Phúc Lý on 21/11/2020.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import UIKit
import Cosmos

class RatingTableViewCell: UITableViewCell {

    @IBOutlet weak var imgViewThumbnail: UIImageView!
    @IBOutlet weak var lbUserName: UILabel!
    @IBOutlet weak var viewRating: CosmosView!
    @IBOutlet weak var lbDate: UILabel!
    @IBOutlet weak var lbComment: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupUI() {
        imgViewThumbnail.afterEffect(cornerRadius: 5.0, borderWidth: 0.0, borderColor: .clear)
    }
    
    func setData(courseRating: CourseRating) {
        if let imageName = courseRating.idUser?.image {
            imgViewThumbnail.sd_setImage(with: URL(string: "\(Common.link.getAvatar)/\(imageName)"), placeholderImage: UIImage(named: Common.imageName.logo))
        }
        
        lbUserName.text = courseRating.idUser?.name
        viewRating.rating = Double(courseRating.numStar ?? 0)
        if let commentDate = courseRating.create_at?.toDate() {
            lbDate.text = commentDate.toString()
        }
        lbComment.text = courseRating.content
        
        
    }
}
