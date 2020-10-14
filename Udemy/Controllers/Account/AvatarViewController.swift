//
//  AvatarViewController.swift
//  Udemy
//
//  Created by Phúc Lý on 10/13/20.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import UIKit
import AVFoundation

class AvatarViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    // Closure
    var updateAvatarSuccessfully: ((UIImage) -> Void)?
    
    // Compenents
    var avatarImageView: UIImageView?
    var pickImageBtn: UIButton?
    var updateBtn: UIButton?
    
    // Variables
    var width:CGFloat {
        get {
            return self.view.bounds.width
        }
    }
    var height: CGFloat {
        get {
            return self.view.bounds.height
        }
    }
    var heightButton: CGFloat {
        get {
            return width * (UIDevice.current.userInterfaceIdiom == .phone ? 0.12 : 0.08)
        }
    }
    var widthButton: CGFloat {
        get {
            return width * (UIDevice.current.userInterfaceIdiom == .phone ? 0.4 : 0.3)
        }
    }
    var widthImage: CGFloat {
        get {
            return width * (UIDevice.current.userInterfaceIdiom == .phone ? 0.8 : 0.6)
        }
    }
    
    
    var marginSpace: CGFloat = UIDevice.current.userInterfaceIdiom == .pad ? 20.0: 10.0
    var account: Account? {
        get {
            guard let appDelegate = (UIApplication.shared.delegate as? AppDelegate) else {
                return nil
            }
            return appDelegate.account
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Title
        title = "Avatar"
        
        // Background
        view.backgroundColor = .systemBackground
        
        
        // Components
        initializeAvatarImageView(&avatarImageView, account?.imageName)
        initializePickImageBtn(&pickImageBtn, "Pick Image", avatarImageView?.bottomAnchor, 3 * marginSpace)
        initializeBottomButton(&updateBtn, "Update", pickImageBtn?.bottomAnchor, 0)
        
        
        updateBtn?.isEnabled = false
        updateBtn?.isHighlighted = false
    }
    
    @objc func pickImageBtnPressed(_ sender: UIButton) {
        showPickerImageActionSheet()
    }
    
    @objc func updateBtnPressed(_ sender: UIButton) {
        
        guard let appDelegate = (UIApplication.shared.delegate as? AppDelegate) else {
            return
        }
        guard let image = avatarImageView?.image, let imageName = appDelegate.account._id else {
            return
        }

        updateAvatarNameToServer(Common.link.changeAvatar, image, imageName)
    }
}


// MARK: - Functions support
extension AvatarViewController {
    func showPickerImageActionSheet() {
        
        let alertStyle: UIAlertController.Style = UIDevice.current.userInterfaceIdiom == .phone ? .actionSheet : .alert
        let alert = UIAlertController(title: "Images", message: "Choose an option to continue" , preferredStyle: alertStyle )
        
        let cameraAction = UIAlertAction(title: "Camera", style: .default , handler:{ (UIAlertAction) in
            self.getImage(fromSourceType: .camera)
        })
        let libraryAction = UIAlertAction(title: "Library", style: .default , handler:{ (UIAlertAction) in
            self.getImage(fromSourceType: .photoLibrary)
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler:{ (UIAlertAction) in
            
        })
        alert.addAction(cameraAction)
        alert.addAction(libraryAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: {
            self.updateBtn?.isEnabled = true
            self.updateBtn?.isHighlighted = true
        })
    }
    
    func getImage(fromSourceType sourceType: UIImagePickerController.SourceType) {
        //Check is source type available
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            imagePickerController.allowsEditing = true
            imagePickerController.sourceType = sourceType
            self.present(imagePickerController, animated: true, completion: nil)
        }
    }
    
}


//MARK:- UIImagePickerViewDelegate.
extension AvatarViewController {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var selectedImageFromPicker: UIImage?
        if let originImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            selectedImageFromPicker = originImage
        }
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            selectedImageFromPicker = editedImage
        }
        if let selectedImage = selectedImageFromPicker {
            // After select image successfully
            avatarImageView?.image = selectedImage
            
        }
        self.dismiss(animated: true, completion: nil)
    }
}
