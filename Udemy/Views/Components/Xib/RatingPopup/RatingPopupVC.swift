//
//  RatingPopupVC.swift
//  Udemy
//
//  Created by Phúc Lý on 22/12/2020.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import UIKit
import Cosmos

class RatingPopupVC: UIViewController {
    
    var onTapSendReview: ((Int, String) -> Void)?

    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var reviewTxtView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        reviewTxtView.toolbarPlaceholder = "Enter your review"
    }

    
    @IBAction func sendBtnPressed(_ sender: UIButton) {
        if let onTapSendReview = onTapSendReview {
            onTapSendReview(Int(ratingView.rating), reviewTxtView.text)
        }
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func cancelBtnPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
