//
//  AvatarView.swift
//  Udemy
//
//  Created by Phúc Lý on 10/13/20.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD

extension AvatarViewController {
    func initializeAvatarImageView(_ imgView: inout UIImageView?, _ imageName: String?) {
        imgView = UIImageView()
        
        guard let imgView = imgView else {
            return
        }
        
        
        imgView.addToViewByConstraints(parent: view, top: nil, bottom: nil, leading: nil, trailing: nil, centerY: YAnchor(direction: view.centerYAnchor, constant: 0), centerX: XAnchor(direction: view.centerXAnchor, constant: 0), width: widthImage, height: widthImage)
        
        imgView.layer.cornerRadius = widthImage / 2
        imgView.contentMode = .scaleAspectFill
        imgView.layer.masksToBounds = true
        //
        // Set image:
        //
        // Set image
        guard let avatar = account?.avatar else {
            // 2. Get image from Server - (fix slow response avatar when login)
            guard let imageName = account?.imageName else {
                return
            }
            guard let url = URL(string: "\(Common.link.getAvatar)/\(imageName)") else {
                return
            }
            
            AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).response {
                    response in
                
                guard let data = response.data else {
                    return
                }
                guard let image = UIImage(data: data) else {
                    return
                }
                imgView.image = image
            }
            
            return
        }
        imgView.image = avatar
    }
    
    func initializePickImageBtn(_ button: inout UIButton?, _ title: String, _ topAnchor: NSLayoutYAxisAnchor?, _ topConstant: CGFloat) {
        button = UIButton()
        
        guard let button = button, let topAnchor = topAnchor else {
            return
        }
        
        button.setTitle(title, for: .normal)
        button.setTitleColor(.blue, for: .normal)
        
        button.addToViewByConstraints(parent: view,
                                      top: YAnchor(direction: topAnchor, constant: topConstant),
                                      bottom: nil,
                                      leading: nil,
                                      trailing: nil,
                                      centerY: nil,
                                      centerX: XAnchor(direction: view.centerXAnchor, constant: 0),
                                      width: widthButton,
                                      height: heightButton)
        
        button.addTarget(self, action: #selector(AvatarViewController.pickImageBtnPressed(_:)), for: .touchUpInside)
    }
    
    // Bottom Button
    func initializeBottomButton(_ button: inout UIButton?, _ title: String, _ topAnchor: NSLayoutYAxisAnchor?, _ topConstant: CGFloat) {
        button = UIButton(title, Common.color.blue, .white, nil)
        guard let button = button, let topAnchor = topAnchor else {
            return
        }
        
        button.addToViewByConstraints(parent: view,
                                      top: YAnchor(direction: topAnchor, constant: topConstant),
                                      bottom: nil,
                                      leading: nil,
                                      trailing: nil,
                                      centerY: nil,
                                      centerX: XAnchor(direction: view.centerXAnchor, constant: 0),
                                      width: widthButton,
                                      height: heightButton)
        
        button.afterEffect(textSize: heightButton * 0.5, corner: heightButton * 0.2)
        button.addTarget(self, action: #selector(AvatarViewController.updateBtnPressed(_:)), for: .touchUpInside)
    }
}
