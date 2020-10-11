//
//  SimpleTableViewCell.swift
//  Udemy
//
//  Created by Phúc Lý on 10/11/20.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import UIKit

class SimpleTableViewCell: UITableViewCell {
    @IBOutlet weak var imgView: UIImageView?
    @IBOutlet weak var label: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        guard let label = label else {
            return
        }
        label.font = UIFont(name: Common.fontName, size: label.bounds.height * 0.4)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
