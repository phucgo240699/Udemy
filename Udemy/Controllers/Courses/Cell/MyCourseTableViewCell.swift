//
//  CourseTableViewCell.swift
//  Udemy
//
//  Created by Phúc Lý on 16/11/2020.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import UIKit
import SDWebImage

class MyCourseTableViewCell: UITableViewCell {

    @IBOutlet weak var container: UIView!
    @IBOutlet weak var imgViewThumbnail: UIImageView!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    private func setupUI() {
        container.afterEffect(cornerRadius: 10, borderWidth: 0, borderColor: .clear)
        container.dropShadow(color: .lightGray, opacity: 0.3, offSet: CGSize(width: 5.0, height: 5.0), radius: 5.0, scale: false)
    }
    
    func setData(course: JoinedCourse) {
        if let imageName = course.idCourse?.image {
            imgViewThumbnail.sd_setImage(with: URL(string: "\(Common.link.getCourseThumbnail)/\(imageName)"), completed: nil)
        }
        lbName.text = course.idCourse?.name
        progressView.progress = Float(course.percentCompleted ?? 0) / 100.0
    }
}
