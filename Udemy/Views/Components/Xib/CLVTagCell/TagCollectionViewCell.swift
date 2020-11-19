//
//  TagCollectionViewCell.swift
//  Udemy
//
//  Created by Phúc Lý on 18/11/2020.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import UIKit

class TagCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var container: UIView!
    @IBOutlet weak var lbTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: self.lbTitle.intrinsicContentSize.width + 50, height: 34)
    }
    
    func setupUI() {
        container.afterEffect(cornerRadius: 5.0, borderWidth: 0.0, borderColor: .clear)
    }
    
    func setData(title: String?) {
        lbTitle.text = title
    }

}
