//
//  DocumentCell.swift
//  Udemy
//
//  Created by Phúc Lý on 27/12/2020.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import UIKit

class DocumentCell: UITableViewCell {
    
    var onTapShare: (() -> Void)?

    @IBOutlet weak var container: UIView!
    @IBOutlet weak var imgViewThumbnail: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    
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
        container.dropShadow(color: .lightGray, opacity: 0.5, offSet: CGSize(width: 3.0, height: 3.0), radius: 5.0, scale: false)
    }
    
    func setData(title: String) {
        // Name
        lbTitle.text = title
        
        // Type
        let arr = title.split(separator: ".")
        let type = arr[arr.count - 1].lowercased()
        if type.contains("doc") {
            imgViewThumbnail.image = UIImage(named: Common.imageName.wordFile)
        }
        else if type.contains("xls") {
            imgViewThumbnail.image = UIImage(named: Common.imageName.xlsFile)
        }
        else if type.contains("ppt") {
            imgViewThumbnail.image = UIImage(named: Common.imageName.pptFile)
        }
        else if type.contains("pdf") {
            imgViewThumbnail.image = UIImage(named: Common.imageName.pdfFile)
        }
        else {
            imgViewThumbnail.image = UIImage(named: Common.imageName.document)
        }
    }
    
    @IBAction func shareBtnPressed(_ sender: UIButton) {
        if let onTapShare = onTapShare {
            onTapShare()
        }
    }
    
}
