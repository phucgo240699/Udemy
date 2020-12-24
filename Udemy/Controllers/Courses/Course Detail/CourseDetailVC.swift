//
//  CourseDetailVC.swift
//  Udemy
//
//  Created by Phúc Lý on 15/11/2020.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import UIKit
import SVProgressHUD

fileprivate let bannerInfoCellID = "courseDetailBannerInfoCell"
fileprivate let operationCellID = "courseDetailOperationCell"
fileprivate let descriptionCellID = "courseDetailDescriptionCell"
fileprivate let ratingsCellID = "courseDetailRatingsCell"
fileprivate let relatedCoursesCellID = "courseDetailRelatedCourses"

enum CourseDetailCellType: Int {
    case BannerInfo = 0
    case Operation = 1
    case Description = 2
    case Rating = 3
    case RelatedCourses = 4
}

class CourseDetailVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let cellTypes: [CourseDetailCellType] = [ .BannerInfo, .Operation, .Description, .Rating, .RelatedCourses ]
    
    var course: Course?
    var relatedCourses: [Course] = []
    var isJoinedCourse: Bool? {
        didSet {
            if isJoinedCourse == false {
                for index in 0 ..< cellTypes.count {
                    if cellTypes[index] == .Operation {
                        DispatchQueue.main.async {
                            (self.tableView.cellForRow(at: IndexPath(row: index, section: 0)) as? CourseDetailOperationCell)?.isJoinedCourse = false
                        }
                    }
                }
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationItem.title = "Detail"
        navigationController?.navigationBar.isHidden = false
        
        setupUI()
        
        // Check is joined
        RequestAPI.shared.checkJoinedCourse(idUser: course?.idUser?._id, idCourse: course?._id) { (isJoined) in
            if isJoined == false {
                self.isJoinedCourse = false
            }
        }
        
        // Fetch courses
        RequestAPI.shared.fetchCourses(by: course?.category?._id) { (courses) in
            self.relatedCourses = courses
            
            for index in 0 ..< self.cellTypes.count {
                if self.cellTypes[index] == .RelatedCourses {
                    DispatchQueue.main.async {
                        self.tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
                    }
                }
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }
    
}

// MARK: - UITableViewDatasource
extension CourseDetailVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch cellTypes[indexPath.row] {
        case .BannerInfo:
            return UITableView.automaticDimension
        case .Operation:
            return 300.0
        case .Description:
            return UITableView.automaticDimension
        case .Rating:
            return 225
        case .RelatedCourses:
            return 368.0
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellTypes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let appDelegate = (UIApplication.shared.delegate as? AppDelegate) else {
            return UITableViewCell()
        }
        
        switch cellTypes[indexPath.row] {
        case .BannerInfo:
            guard let cell = self.tableView.dequeueReusableCell(withIdentifier: bannerInfoCellID, for: indexPath) as? CourseDetailBannerInfoCell else {
                return UITableViewCell()
            }
            cell.setData(course: course)
            return cell
        case .Operation:
            guard let cell = self.tableView.dequeueReusableCell(withIdentifier: operationCellID, for: indexPath) as? CourseDetailOperationCell else {
                return UITableViewCell()
            }
            cell.isJoinedCourse = isJoinedCourse
            cell.onTapJoinCourseBtn = {
                RequestAPI.shared.joinCourse(idUser: self.course?.idUser?._id, idCourse: self.course?._id) {
                    self.isJoinedCourse = true
                    self.notificate(UIImage(named: Common.imageName.done), "Joined Successfully", "")
                }
            }
            cell.onTapAddToCartBtn = {
                if let course = self.course {
                    (UIApplication.shared.delegate as? AppDelegate)?.cart.courses.append(course)
                    (UIApplication.shared.delegate as? AppDelegate)?.window?.notificate(UIImage(named: Common.imageName.done), "Add to cart successfully", "")
                }
            }
            cell.onTapWriteReviewBtn = {
                let ratingPopup = RatingPopupVC()
                
                ratingPopup.onTapSendReview = { numStar, content in
                    
                    RequestAPI.shared.sendRating(numStar: numStar, content: content, idUser: appDelegate.account._id, idCourse: self.course?._id) {
                        
                        self.notificate(UIImage(named: Common.imageName.done), "Review successfully", "")
                    }
                }
                
                self.present(ratingPopup, animated: true, completion: nil)
            }
            
            cell.setData(course: course)
            return cell
        case .Description:
            guard let cell = self.tableView.dequeueReusableCell(withIdentifier: descriptionCellID, for: indexPath) as? CourseDetailDescriptionCell else {
                return UITableViewCell()
            }
            cell.setData(course: course)
            return cell
            
        case .Rating:
            guard let cell = self.tableView.dequeueReusableCell(withIdentifier: ratingsCellID, for: indexPath) as? CourseDetailRatingCell else {
                return UITableViewCell()
            }
            cell.onTapShowMore = { ratings in
                let ratingsVC = RatingsViewController()
                ratingsVC.ratings = ratings
                self.navigationController?.pushViewController(ratingsVC, animated: true)
            }
            
            fetchRatings(by: course?._id) { (courseRatings) in
                cell.ratings = courseRatings
                let numberOfRatings = courseRatings.count
                if numberOfRatings < 2 {
                    cell.showMoreButton.setTitle("", for: .normal)
                }
                DispatchQueue.main.async {
                    cell.tableView.reloadData()
                }
            }
            return cell
            
        case .RelatedCourses:
            guard let cell = self.tableView.dequeueReusableCell(withIdentifier: relatedCoursesCellID, for: indexPath) as? CourseDetailRelatedCoursesCell else {
                return UITableViewCell()
            }
            cell.onTapRelatedCourse = { course in
                let courseDetailVC = CourseDetailVC()
                courseDetailVC.course = course
                self.navigationController?.pushViewController(courseDetailVC, animated: true)
            }
            cell.courses = relatedCourses
            return cell
            
        }
        
    }
}


// MARK: - UITableViewDelegate
extension CourseDetailVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

// MARK: - Functions Support
extension CourseDetailVC {
    func setupUI() {
        //-- TableView
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "CourseDetailBannerInfoCell", bundle: nil), forCellReuseIdentifier: bannerInfoCellID)
        tableView.register(UINib(nibName: "CourseDetailOperationCell", bundle: nil), forCellReuseIdentifier: operationCellID)
        tableView.register(UINib(nibName: "CourseDetailDescriptionCell", bundle: nil), forCellReuseIdentifier: descriptionCellID)
        tableView.register(UINib(nibName: "CourseDetailRatingCell", bundle: nil), forCellReuseIdentifier: ratingsCellID)
        tableView.register(UINib(nibName: "CourseDetailRelatedCoursesCell", bundle: nil), forCellReuseIdentifier: relatedCoursesCellID)
    }
}
