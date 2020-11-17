//
//  OrderedCourseTableViewCell.swift
//  Udemy
//
//  Created by Phúc Lý on 17/11/2020.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import UIKit
import SDWebImage

class OrderedCourseTableViewCell: UITableViewCell {
    
    // Closures
    var onTapPaymentBtn: (() -> Void)?

    // Compenents
    @IBOutlet weak var imgViewThumbnail: UIImageView!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbAuthor: UILabel!
    @IBOutlet weak var lbPrice: UILabel!
    
    @IBOutlet weak var btnPayment: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(course: Course) {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        
        if let imageName = course.image {
            imgViewThumbnail.sd_setImage(with: URL(string: "\(Common.link.getCourseThumbnail)/\(imageName)"), completed: nil)
        }
        
        lbName.text = course.name
        lbAuthor.text = course.idUser?.name
        
        let restPercent:Double = 1 - Double(course.discount ?? 0)
        let originalPrice: Double = Double(course.price ?? 0)
        lbPrice.text = formatter.string(from: NSNumber(value: restPercent * originalPrice))
    }
    
    @IBAction func paymentBtnPressed(_ sender: UIButton) {
        if let onTapPaymentBtn = onTapPaymentBtn {
            onTapPaymentBtn()
        }
    }
    
}
