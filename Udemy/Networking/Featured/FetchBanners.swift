//
//  FetchBanners.swift
//  Udemy
//
//  Created by Phúc Lý on 11/10/20.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import UIKit
import SDWebImage

extension FeatureViewController {
    func fetchBanners(imagesURLs: [String]) {
        for index in 0..<bannerPageViewController.subViewControllers.count {
            let imageView = UIImageView(frame: bannerPageViewController.subViewControllers[index].view.bounds)
            imageView.contentMode = .scaleToFill
            imageView.sd_setImage(with: URL(string: imagesURLs[index]), completed: nil)
            bannerPageViewController.subViewControllers[index].view.addSubview(imageView)
        }
    }
}
