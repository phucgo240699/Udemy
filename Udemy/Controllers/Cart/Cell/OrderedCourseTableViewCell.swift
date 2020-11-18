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
        
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupUI() {
        // Image View
        imgViewThumbnail.afterEffect(cornerRadius: 5.0, borderWidth: 0.0, borderColor: .clear)
        
        // Payment Button
        btnPayment.afterEffect(cornerRadius: 5.0, borderWidth: 0.0, borderColor: .clear)
        btnPayment.dropShadow(color: Common.color.textColor, opacity: 0.5, offSet: CGSize(width: 2, height: 3), radius: 3.0, scale: false)
    }
    
    func setData(course: Course) {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
    
        if let imageName = course.image {
            imgViewThumbnail.sd_setImage(with: URL(string: "\(Common.link.getCourseThumbnail)/\(imageName)"), completed: nil)
        }
        
        lbName.text = course.name
        lbAuthor.text = course.idUser?.name
        lbPrice.text = String(course.discountPrice ?? 0)
    }
    
    @IBAction func paymentBtnPressed(_ sender: UIButton) {
        if let onTapPaymentBtn = onTapPaymentBtn {
            onTapPaymentBtn()
        }
    }
    
}
