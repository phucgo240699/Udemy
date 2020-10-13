//
//  Window.swift
//  Udemy
//
//  Created by Phúc Lý on 9/30/20.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import Foundation
import UIKit
import SwiftEntryKit

extension UIWindow {
    func setController(_ value: CurrentController) {
        let appDelegate = (UIApplication.shared.delegate as! AppDelegate)
        switch value {
        case .login:
            appDelegate.currentController = .login
            self.rootViewController = appDelegate.loginController
        default:
            appDelegate.currentController = .mainTab
            appDelegate.mainTabBarController = MainTabBarController()
            self.rootViewController = appDelegate.mainTabBarController
        }
    }
    func showError(_ title: String = "Error", _ message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { (action) in
            self.rootViewController?.dismiss(animated: true, completion: nil)
        }	
        
        alert.addAction(okAction)
        self.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
    func notificate(_ image: UIImage? = UIImage(named: Common.imageName.done), _ title: String, _ description: String) {
        if let img = image {
            SwiftEntryKit.display(entry: NotificationPopup(with: getMessage(img, title, description)), using: getAttributes())
        }
    }
    
    func showTwoInputsAlert(_ title: String, _ description: String, _ callback: (String, String) -> Void, _ placeholder1: String, _ placeholder2: String ) {
        
        var textField1: UITextField? = UITextField()
        var textField2: UITextField? = UITextField()
        let alert = UIAlertController(title: title, message: description, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { (action) in
            
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { (action) in
            self.rootViewController?.dismiss(animated: true, completion: nil)
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = placeholder1
            textField1 = alertTextField
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = placeholder2
            textField2 = alertTextField
        }
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        self.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
    func getMessage(_ image: UIImage, _ title: String,_ description: String) -> EKPopUpMessage {
        
        let themeImage = EKPopUpMessage.ThemeImage(image: EKProperty.ImageContent(image: image, size: CGSize(width: 60, height: 60), tint: .black, contentMode: .scaleAspectFit))
        
        let titleLabel = EKProperty.LabelContent(text: title, style: .init(font: UIFont.systemFont(ofSize: 24),
                                                                           color: .init(light: .black, dark: .white),
                                                                           alignment: .center))
        
        let descriptionLabel = EKProperty.LabelContent(
            text: description,
            style: .init(
                font: UIFont.systemFont(ofSize: 16),
                color: .init(light: .black, dark: .white),
                alignment: .center
            )
        )
        
        let button = EKProperty.ButtonContent(
            label: .init(
                text: "Got it!",
                style: .init(
                    font: UIFont.systemFont(ofSize: 16),
                    color: .black
                )
            ),
            backgroundColor: .init(UIColor.systemOrange),
            highlightedBackgroundColor: .clear
        )
        
        let message = EKPopUpMessage(themeImage: themeImage, title: titleLabel, description: descriptionLabel, button: button) {
            SwiftEntryKit.dismiss()
        }
        return message
    }
    
    func getAttributes() -> EKAttributes {
        var attributes = EKAttributes.centerFloat
        attributes.displayDuration = .infinity
        attributes.screenBackground = .color(color: .init(light: UIColor(white: 100.0/255.0, alpha: 0.3), dark: UIColor(white: 50.0/255.0, alpha: 0.3)))
        attributes.shadow = .active(
            with: .init(
                color: .black,
                opacity: 0.3,
                radius: 8
            )
        )
        
        attributes.entryBackground = .color(color: .standardBackground)
        attributes.roundCorners = .all(radius: 25)
        
        attributes.screenInteraction = .dismiss
        attributes.entryInteraction = .absorbTouches
        attributes.scroll = .enabled(
            swipeable: true,
            pullbackAnimation: .jolt
        )
        
        attributes.entranceAnimation = .init(
            translate: .init(
                duration: 0.7,
                spring: .init(damping: 1, initialVelocity: 0)
            ),
            scale: .init(
                from: 1.05,
                to: 1,
                duration: 0.4,
                spring: .init(damping: 1, initialVelocity: 0)
            )
        )
        
        attributes.exitAnimation = .init(
            translate: .init(duration: 0.2)
        )
        attributes.popBehavior = .animated(
            animation: .init(
                translate: .init(duration: 0.2)
            )
        )
        
        attributes.positionConstraints.verticalOffset = 10
        attributes.statusBar = .dark
        return attributes
    }
}
