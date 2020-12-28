//
//  CreateCourseVC.swift
//  Udemy
//
//  Created by Phúc Lý on 25/12/2020.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import UIKit
import DropDown

protocol CreateCourseVCDelegate: class {
    func didCreateSuccessfully()
    func didUpdateSuccessfully()
}

class CreateCourseVC: UIViewController {
    
    // Components UI
    var addBarButton: UIBarButtonItem?
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var tfGoal: UITextField!
    @IBOutlet weak var lbDescription: UILabel!
    @IBOutlet weak var tvDescription: UITextView!
    @IBOutlet weak var chooseCategoryBtn: UIButton!
    @IBOutlet weak var tfPrice: UITextField!
    @IBOutlet weak var tfDiscount: UITextField!
    @IBOutlet weak var stkBtn: UIStackView!
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    // Data
    var choseCategory: Category?
    
    // Edit
    var isEditForm: Bool = false
    var updateCourse: Course?
    
    // Delegate
    weak var delegate: CreateCourseVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    func setupUI() {
        
        if isEditForm {
            tfName.text = updateCourse?.name
            tfGoal.text = updateCourse?.goal
            tvDescription.text = updateCourse?.description
            
            chooseCategoryBtn.setTitle(updateCourse?.category?.name, for: .normal)
            if let price = updateCourse?.price {
                tfPrice.text = "\(price)"
            }
            if let discount = updateCourse?.discount {
                tfDiscount.text = "\(discount)"
            }
            if let image = updateCourse?.image {
                imgView.sd_setImage(with: URL(string: "\(Common.link.getCourseThumbnail)/\(image)"), completed: nil)
            }
            choseCategory = updateCourse?.category
        }
        
        self.enableTapToDismiss()
        
        //-- Navigation
        addBarButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(CreateCourseVC.addCourseBarBtnPressed(_:)))
        addBarButton?.isEnabled = false
        navigationController?.navigationItem.title = "Create Courses"
        navigationItem.rightBarButtonItem = addBarButton
        
        
        //-- TextField & TextView
        tfName.delegate = self
        tfGoal.delegate = self
        tvDescription.delegate = self
        tfPrice.delegate = self
        tfDiscount.delegate = self
        
        tvDescription.clipsToBounds = true
        tvDescription.layer.cornerRadius = 5.0
        
    }
    
    @IBAction func chooseCategoryBtnPressed(_ sender: UIButton) {
        let categoryNameVC = CategoryNameVC()
        categoryNameVC.delegate = self
        navigationController?.pushViewController(categoryNameVC, animated: true)
    }
    @IBAction func chooseImageBtnPressed(_ sender: UIButton) {
        showPickerImageActionSheet()
    }
    
    
    @objc func addCourseBarBtnPressed(_ sender: UIBarButtonItem) {
        if isEditForm {
            RequestAPI.shared.updateCourse(by: updateCourse?._id, name: tfName.text, goal: tfGoal.text, description: tvDescription.text, categoryId: choseCategory?._id, price: Int(tfPrice.text ?? ""), discount: Int(tfDiscount.text ?? ""), image: imgView.image, imageName: updateCourse?.image ) {
                self.navigationController?.popViewController(animated: true)
                self.delegate?.didUpdateSuccessfully()
            }
            return
        }
        
        guard let name = tfName.text,
              let goal = tfGoal.text,
              let description = tvDescription.text,
              let categoryId = choseCategory?._id,
              let priceString = tfPrice.text,
              let discountString = tfDiscount.text,
              let image = imgView.image else {
            return
        }
        
        guard let discount = Int(discountString),
              let price = Int(priceString) else {
            return
        }
        
        RequestAPI.shared.createCourse(name: name, goal: goal, description: description, categoryId: categoryId, price: price, discount: discount, image: image) {
            self.navigationController?.popViewController(animated: true)
            self.delegate?.didCreateSuccessfully()
        }
        
    }
    
    func isValidForm() -> Bool {
        
        if isEditForm {
            if let discountString = tfDiscount.text {
                if let discount = Int(discountString) {
                    if discount < 0 || discount > 100 {
                        return false
                    }
                }
            }
            
            return true
        }
        
        if tfName.text?.isEmptyOrSpacing() == true {
            return false
        }
        if tfGoal.text?.isEmptyOrSpacing() == true {
            return false
        }
        if tvDescription.text?.isEmptyOrSpacing() == true {
            return false
        }
        if tfPrice.text?.isEmptyOrSpacing() == true {
            return false
        }
        guard let discountString = tfDiscount.text else {
            return false
        }
        guard let discount = Int(discountString) else {
            return false
        }
        if discount < 0 || discount > 100 {
            return false
        }
        
        if choseCategory == nil {
            return false
        }
        
        if imgView.image == nil {
            return false
        }
        
        return true
    }
}

// MARK: - Category Delegate
extension CreateCourseVC: CategoryNameVCDelegate {
    func didChooseCategory(category: Category) {
        choseCategory = category
        chooseCategoryBtn.setTitle(category.name, for: .normal)
        addBarButton?.isEnabled = isValidForm()
    }
}


// MARK: TextView Delegate
extension CreateCourseVC: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        addBarButton?.isEnabled = isValidForm()
    }
}


// MARK: TextField Delegate
extension CreateCourseVC: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        addBarButton?.isEnabled = isValidForm()
    }
}

// MARK: - Image Picker
extension CreateCourseVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func showPickerImageActionSheet() {
        
        let alert = UIAlertController(title: "Images", message: "Choose an option to continue" , preferredStyle: .actionSheet)
        
        let cameraAction = UIAlertAction(title: "Camera", style: .default , handler:{ (UIAlertAction)in
            self.getImage(fromSourceType: .camera)
        })
        let libraryAction = UIAlertAction(title: "Library", style: .default , handler:{ (UIAlertAction)in
            self.getImage(fromSourceType: .photoLibrary)
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler:{ (UIAlertAction)in
            
        })
        alert.addAction(cameraAction)
        alert.addAction(libraryAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
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
            self.imgView.image = selectedImage
            addBarButton?.isEnabled = isValidForm()
            
        }
        self.dismiss(animated: true, completion: nil)
    }
}
