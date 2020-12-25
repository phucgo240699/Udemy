//
//  CreateCourseVC.swift
//  Udemy
//
//  Created by Phúc Lý on 25/12/2020.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import UIKit
import DropDown

class CreateCourseVC: UIViewController {
    
    var addBarButton: UIBarButtonItem?
    
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var tfGoal: UITextField!
    @IBOutlet weak var tvDescription: UITextView!
    @IBOutlet weak var chooseCategoryBtn: UIButton!
    @IBOutlet weak var tfPrice: UITextField!
    @IBOutlet weak var tfDiscount: UITextField!
    
    var choseCategory: Category?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
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
    }
    
    @IBAction func chooseCategoryBtnPressed(_ sender: UIButton) {
        let categoryNameVC = CategoryNameVC()
        categoryNameVC.delegate = self
        navigationController?.pushViewController(categoryNameVC, animated: true)
    }
    
    
    @objc func addCourseBarBtnPressed(_ sender: UIBarButtonItem) {
        let createCourseVC = CreateCourseVC()
        navigationController?.pushViewController(createCourseVC, animated: true)
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
        if tfDiscount.text?.isEmptyOrSpacing() == true {
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
