//
//  FeatureViewController.swift
//  Udemy
//
//  Created by Phúc Lý on 10/1/20.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//


// README:
// tag ( 3, 0, 1, 2 ): category, newCourses, freeCourses, topCourses

import Foundation
import UIKit

class FeatureViewController: UIViewController {
    
    // Variables
    var width: CGFloat {
        get {
            return self.view.bounds.width
        }
    }
    var height: CGFloat {
        get {
            return self.view.bounds.height
        }
    }
    
    var bannerHeight: CGFloat {
        get {
            return height * 0.3
        }
    }
    var categoryCollectionViewHeight: CGFloat {
        get {
            return height * 0.2
        }
    }
    var courseCollectionViewHeight: CGFloat {
        get {
            return height * 0.4
        }
    }
    var margin: CGFloat {
        get {
            return UIDevice.current.userInterfaceIdiom == .pad ? 20: 10
        }
    }
    
    
    // Compenents
    var scrollView: UIScrollView = UIScrollView()
    var bannerPageViewController: PageViewController = PageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    var categoriesCollectionView: UICollectionView?
    var newCoursesCollectionView: UICollectionView?
    var freeCoursesCollectionView: UICollectionView?
    var topCoursesCollectionView: UICollectionView?
    
    // Datasources
    var listCategories: [Category] = []
    var listNewCourses: [Course] = []
    var listFreeCourses: [Course] = []
    var listTopCourses: [Course] = []
    
    var titleCollectionViews: [String] = ["New", "Free", "Top", "Category"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.backgroundColor = Common.color.silverBackground
        
        // Components
        scrollView.frame = view.bounds
        view.addSubview(scrollView)
        scrollView.contentSize = CGSize(width: width, height: bannerHeight + 3 * courseCollectionViewHeight + categoryCollectionViewHeight + 8 * margin + 2 * margin)
        
        setUpBanner()
        
        // Category
        initializeCollectionView(&categoriesCollectionView, YAnchor(direction: bannerPageViewController.view.bottomAnchor, constant: 2 * margin), categoryCollectionViewHeight, 3, "categoryCLVCell")
        
        // New Course
        if let categoriesCollectionView = categoriesCollectionView {
            initializeCollectionView(&newCoursesCollectionView, YAnchor(direction: categoriesCollectionView.bottomAnchor, constant: 2 * margin), courseCollectionViewHeight, 0, "newCourseCLVCell")
        }
        
        // Free Course
        if let newCoursesCollectionView = newCoursesCollectionView {
            initializeCollectionView(&freeCoursesCollectionView, YAnchor(direction: newCoursesCollectionView.bottomAnchor, constant: 2 * margin), courseCollectionViewHeight, 1, "freeCourseCLVCell")
        }
        
        // Top Course
        if let freeCoursesCollectionView = freeCoursesCollectionView {
            initializeCollectionView(&topCoursesCollectionView, YAnchor(direction: freeCoursesCollectionView.bottomAnchor, constant: 2 * margin), courseCollectionViewHeight, 2, "topCourseCLVCell")
        }
        
        
        // Fetch data
        fetchCategories()
        fetchNewCourses()
        fetchFreeCourses()
        fetchTopCourses()
    }
}

// MARK: - UICollectionView Delegates
extension FeatureViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // Size for Item
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Category
        if collectionView.tag == 3 {
            return CGSize(width: categoryCollectionViewHeight * 1.6, height: categoryCollectionViewHeight * 0.9)
        }
        
        // Courses
        return CGSize(width: courseCollectionViewHeight * 0.9, height: courseCollectionViewHeight * 0.9)
    }
    
    // Number of Items
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 0 {
            return  listNewCourses.count
        }
        else if collectionView.tag == 1 {
            return listFreeCourses.count
        }
        else if collectionView.tag == 2 {
            return listTopCourses.count
        }
        return listCategories.count
    }
    
    // Detail Item
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // New
        if collectionView.tag == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "newCourseCLVCell", for: indexPath) as! CourseCollectionViewCell
            
            cell.fillData(listNewCourses[indexPath.row])
            
            return cell
        }
        
        // Free
        else if collectionView.tag == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "freeCourseCLVCell", for: indexPath) as! CourseCollectionViewCell
            
            cell.fillData(listFreeCourses[indexPath.row])
            
            return cell
        }
        
        // Top
        else if collectionView.tag == 2 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "topCourseCLVCell", for: indexPath) as! CourseCollectionViewCell
            
            cell.fillData(listTopCourses[indexPath.row])
            
            return cell
        }
        
        // Category
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCLVCell", for: indexPath) as! CategoryCollectionViewCell
        
        cell.fillData(listCategories[indexPath.row])
        
        return cell
    }
    
    
}


// MARK: - Functions support
extension FeatureViewController {
    func fillBanner(_ images: [UIImage]) {
        for image in images {
            let vc = UIViewController()
            let imgView = UIImageView(image: image)
            vc.view.insertSubview(imgView, at: 0)
            
            bannerPageViewController.subViewControllers.append(vc)
        }
    }
}
