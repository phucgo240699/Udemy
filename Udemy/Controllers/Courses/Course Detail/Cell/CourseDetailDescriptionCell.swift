//
//  CourseDetailDescriptionCell.swift
//  Udemy
//
//  Created by Phúc Lý on 16/11/2020.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import UIKit

class CourseDetailDescriptionCell: UITableViewCell {

    @IBOutlet weak var txtViewDescription: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(courseDetail: CourseDetail) {
        txtViewDescription.text = courseDetail.description
    }
    
}
