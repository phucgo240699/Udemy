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
    var titleHeight: CGFloat {
        get {
            return 28.0
        }
    }
    
    var bannerHeight: CGFloat {
        get {
            return 200// height * 0.3
        }
    }
    var categoryCollectionViewHeight: CGFloat {
        get {
            return 150// height * 0.2
        }
    }
    var courseCollectionViewHeight: CGFloat {
        get {
            return 300// height * 0.4
        }
    }
    var margin: CGFloat {
        get {
            return UIDevice.current.userInterfaceIdiom == .pad ? 20: 10
        }
    }
    
    
    // Compenents
    var scrollView: UIScrollView = UIScrollView()
    var refreshControl: UIRefreshControl = UIRefreshControl()
    var bannerPageViewController: PageViewController = PageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    var categoriesCollectionView: UICollectionView?
    
    var lbTitleCategory: UILabel?
    var lbTitleNewCourses: UILabel?
    var lbTitleFreeCourses: UILabel?
    var lbTitleTopCourses: UILabel?
    
    var newCoursesCollectionView: UICollectionView?
    var freeCoursesCollectionView: UICollectionView?
    var topCoursesCollectionView: UICollectionView?
    
    // Datasources
    var categories: [Category] = []
    var newCourses: [Course] = []
    var freeCourses: [Course] = []
    var topCourses: [Course] = []
    
    var titleCollectionViews: [String] = ["New Courses", "Free Courses", "Top Courses", "Category"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //-- Navigation
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = Common.color.silverBackground
        
        //-- Scroll view
        scrollView.frame = view.bounds
        view.addSubview(scrollView)
        scrollView.contentSize = CGSize(width: width, height: bannerHeight + 3 * courseCollectionViewHeight + 4 * titleHeight + 4 * margin + categoryCollectionViewHeight + 8 * margin + 2 * margin)
        
        //-- Refresh Control
        refreshControl.addTarget(self, action: #selector(FeatureViewController.refresh(_:)), for: .valueChanged)
        scrollView.addSubview(refreshControl)
        
        setUpBanner()
        
        //--  Category
        initializeCollectionView(&categoriesCollectionView, &lbTitleCategory, YAnchor(direction: bannerPageViewController.view.bottomAnchor, constant: 2 * margin), categoryCollectionViewHeight, 3, "categoryCLVCell")
        
        //-- New Course
        if let categoriesCollectionView = categoriesCollectionView {
            initializeCollectionView(&newCoursesCollectionView, &lbTitleNewCourses, YAnchor(direction: categoriesCollectionView.bottomAnchor, constant: 2 * margin), courseCollectionViewHeight, 0, "newCourseCLVCell")
        }
        
        //-- Free Course
        if let newCoursesCollectionView = newCoursesCollectionView {
            initializeCollectionView(&freeCoursesCollectionView, &lbTitleFreeCourses, YAnchor(direction: newCoursesCollectionView.bottomAnchor, constant: 2 * margin), courseCollectionViewHeight, 1, "freeCourseCLVCell")
        }
        
        //-- Top Course
        if let freeCoursesCollectionView = freeCoursesCollectionView {
            initializeCollectionView(&topCoursesCollectionView, &lbTitleTopCourses, YAnchor(direction: freeCoursesCollectionView.bottomAnchor, constant: 2 * margin), courseCollectionViewHeight, 2, "topCourseCLVCell")
        }
        
        
        //-- Fetch data
        fetchBanners(imagesURLs: [
            "https://img-a.udemycdn.com/course/240x135/2430492_5cdb_5.jpg?dYz1wwu1L-WX614tFAR1WyWrP3OIw6Qwq-Qozt9dUmaDIG04SpZO6VrAOeQl51qKqMPVgjQxOhXkY58ihs1CiJg8m-nC3ap6ZI4JOv5tuty5xn4lM35NMwKknHFhJBr4",
            "https://img-a.udemycdn.com/course/240x135/2153774_bef0_4.jpg?QRwd_FQgq0IXEHmc0eVdpMUTPjks3S_Tc-vNruByBT6uOBocc4Vd0ZELkt30s0H1EeCjlksmtqkLJBJxB63Q535pK2IQhHgsmcCR9cvQ-iaLk3AOC3iru5DNE-RTSTOt",
            "https://img-a.udemycdn.com/course/240x135/1906852_93c6.jpg?XMYkJsti--olwnx3BT1zW7-QtgiVb-gNwoxvaaG6615P3xmd0Wzl00AFWEnL-pWGAtuwBOkaoZ7QWplvHrYvRtD7F8IflMNNMkqnNHT8cRjrSYJcrSV5_K5ok74x9Q"
        ])
        
        RequestAPI.shared.fetchCategories { (categories) in
            self.categories = categories
            
            DispatchQueue.main.async {
                self.categoriesCollectionView?.reloadData()
            }
        }
        RequestAPI.shared.fetchNewCourses { (courses) in
            self.newCourses = courses
            
            DispatchQueue.main.async {
                self.newCoursesCollectionView?.reloadData()
            }
        }
        RequestAPI.shared.fetchFreeCourses { (courses) in
            self.freeCourses = courses
            
            DispatchQueue.main.async {
                self.freeCoursesCollectionView?.reloadData()
            }
        }
//        RequestAPI.shared.fetchTopCourses { (courses) in
//            self.topCourses = courses
//
//            DispatchQueue.main.async {
//                self.topCoursesCollectionView?.reloadData()
//            }
//        }
    }
}

// MARK: - UICollectionViewDatasource, UITableviewDelegateFlowLayout
extension FeatureViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
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
            return  newCourses.count
        }
        else if collectionView.tag == 1 {
            return freeCourses.count
        }
        else if collectionView.tag == 2 {
            return topCourses.count
        }
        return categories.count
    }
    
    // Detail Item
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // New
        if collectionView.tag == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "newCourseCLVCell", for: indexPath) as! CourseCollectionViewCell
            
            cell.fillData(newCourses[indexPath.row])
            
            return cell
        }
        
        // Free
        else if collectionView.tag == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "freeCourseCLVCell", for: indexPath) as! CourseCollectionViewCell
            
            cell.fillData(freeCourses[indexPath.row])
            
            return cell
        }
        
        // Top
        else if collectionView.tag == 2 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "topCourseCLVCell", for: indexPath) as! CourseCollectionViewCell
            
            cell.fillData(topCourses[indexPath.row])
            
            return cell
        }
        
        // Category
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCLVCell", for: indexPath) as! CategoryCollectionViewCell
        
        cell.fillData(categories[indexPath.row])
        
        return cell
    }
    
    
}

// MARK: - UICollectionViewDelegate
extension FeatureViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var course: Course?
        
        switch collectionView.tag {
            case 0:
                course = newCourses[indexPath.row]
                break
            case 1:
                course = freeCourses[indexPath.row]
                break
            case 2:
                course = topCourses[indexPath.row]
                break
            default:
                let categoryId = categories[indexPath.row]._id
                RequestAPI.shared.fetchCourses(by: categoryId) { (courses) in
                    let searchResultVC = SearchResultViewController()
                    
                    for index in 0 ..< courses.count {
                        searchResultVC.courses.append(courses[index].getRegularCourse())
                    }
                    
                    DispatchQueue.main.async {
                        self.navigationController?.pushViewController(searchResultVC, animated: true)
                    }
                }
                break
        }
        
        if let course = course {
            let courseDetailVC = CourseDetailVC(nibName: "CourseDetailVC", bundle: nil)
            courseDetailVC.course = course
            navigationController?.pushViewController(courseDetailVC, animated: true)
        }
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
    
    @objc func refresh(_ sender: UIRefreshControl) {
        RequestAPI.shared.fetchCategories { (categories) in
            self.categories = categories
            
            DispatchQueue.main.async {
                self.categoriesCollectionView?.reloadData()
            }
        }
        RequestAPI.shared.fetchNewCourses { (courses) in
            self.newCourses = courses
            
            DispatchQueue.main.async {
                self.newCoursesCollectionView?.reloadData()
            }
        }
        RequestAPI.shared.fetchFreeCourses { (courses) in
            self.freeCourses = courses
            
            DispatchQueue.main.async {
                self.freeCoursesCollectionView?.reloadData()
            }
        }
        RequestAPI.shared.fetchTopCourses { (courses) in
            self.topCourses = courses
            
            DispatchQueue.main.async {
                self.topCoursesCollectionView?.reloadData()
            }
        }
        
        
        sender.endRefreshing()
    }
}
