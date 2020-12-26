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
}

class CreateCourseVC: UIViewController {
    
    // Components UI
    var addBarButton: UIBarButtonItem?
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var tfGoal: UITextField!
    @IBOutlet weak var tvDescription: UITextView!
    @IBOutlet weak var chooseCategoryBtn: UIButton!
    @IBOutlet weak var tfPrice: UITextField!
    @IBOutlet weak var tfDiscount: UITextField!
    
    
    // Data
    var choseCategory: Category?
    
    
    // Delegate
    weak var delegate: CreateCourseVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    func setupUI() {
        
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
    
    
    @objc func addCourseBarBtnPressed(_ sender: UIBarButtonItem) {
        guard let name = tfName.text,
              let goal = tfGoal.text,
              let description = tvDescription.text,
              let categoryId = choseCategory?._id,
              let priceString = tfPrice.text,
              let discountString = tfDiscount.text else {
            return
        }
        guard let discount = Int(discountString),
              let price = Int(priceString) else {
            return
        }
        
        RequestAPI.shared.createCourse(name: name, goal: goal, description: description, categoryId: categoryId, price: price, discount: discount) {
            self.navigationController?.popViewController(animated: true)
            self.delegate?.didCreateSuccessfully()
        }

    }
    
    func isValidForm() -> Bool {
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
