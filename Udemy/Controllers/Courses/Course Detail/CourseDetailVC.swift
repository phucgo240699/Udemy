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
    
    
    var courseRatings: [CourseRating] = []
    var isShowAll: Bool = false
    
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
                        self.tableView.reloadSections(IndexSet(integer: CourseDetailCellType.RelatedCourses.rawValue), with: .automatic)
                    }
                }
            }
        }

        // Fetch courseRatings
        RequestAPI.shared.fetchRatings(by: course?._id) { (ratings) in
            if ratings.count < 3 {
                self.courseRatings = ratings
            }
            else {
                self.courseRatings = [ ratings[0], ratings[1] ]
                self.isShowAll = true
            }

            self.tableView.reloadData()
        }
        
    }
    
}

// MARK: - UITableViewDatasource
extension CourseDetailVC: UITableViewDataSource {
    
    // Row & Section
    func numberOfSections(in tableView: UITableView) -> Int {
        return cellTypes.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if cellTypes[section] == .Rating {
            return courseRatings.count
        }
        
        return 1
    }
    
    
    // -- Header
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if cellTypes[section] == .Rating && courseRatings.count != 0 {
            return UITableView.automaticDimension
        }
        return 0.0
    }
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        if cellTypes[section] == .Rating && courseRatings.count != 0 {
            return 44.0
        }
        return 0.0
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if cellTypes[section] == .Rating && courseRatings.count != 0 {
            let label = UILabel()
            label.font = UIFont(name: Common.fontName, size: 20.0)
            label.textColor = Common.color.textColor
            label.backgroundColor = .clear
            label.text = "Reviews"
            return label
        }
        return nil
    }
    
    
    // -- Footer
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if cellTypes[section] == .Rating && self.isShowAll {
            return UITableView.automaticDimension
        }
        return 0.0
    }
    func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        if cellTypes[section] == .Rating && courseRatings.count != 0 {
            return 44.0
        }
        return 0.0
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if cellTypes[section] == .Rating && self.isShowAll {
            let btn = UIButton()
            btn.setTitle("Show all", for: .normal)
            btn.setTitleColor(Common.color.blue, for: .normal)
            btn.backgroundColor = .clear
            btn.addTarget(self, action: #selector(CourseDetailVC.footerRatingBtnPressed(_:)), for: .touchUpInside)
            return btn
        }
        return nil
    }
    
    
    
    // -- Row
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch cellTypes[indexPath.section] {
        case .BannerInfo:
            return UITableView.automaticDimension
        case .Operation:
            return 300.0
        case .Description:
            return UITableView.automaticDimension
        case .Rating:
            return UITableView.automaticDimension
        case .RelatedCourses:
            return 368.0
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let appDelegate = (UIApplication.shared.delegate as? AppDelegate) else {
            return UITableViewCell()
        }
        
        switch cellTypes[indexPath.section] {
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
            guard let cell = self.tableView.dequeueReusableCell(withIdentifier: ratingsCellID, for: indexPath) as? RatingTableViewCell else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            cell.setData(courseRating: courseRatings[indexPath.row])
            
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
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "CourseDetailBannerInfoCell", bundle: nil), forCellReuseIdentifier: bannerInfoCellID)
        tableView.register(UINib(nibName: "CourseDetailOperationCell", bundle: nil), forCellReuseIdentifier: operationCellID)
        tableView.register(UINib(nibName: "CourseDetailDescriptionCell", bundle: nil), forCellReuseIdentifier: descriptionCellID)
        tableView.register(UINib(nibName: "RatingTableViewCell", bundle: nil), forCellReuseIdentifier: ratingsCellID)
        tableView.register(UINib(nibName: "CourseDetailRelatedCoursesCell", bundle: nil), forCellReuseIdentifier: relatedCoursesCellID)
    }
    
    @objc func footerRatingBtnPressed(_ sender: UIButton) {
        let ratingVC = RatingsViewController()
        ratingVC.idCourse = course?._id
        navigationController?.pushViewController(ratingVC, animated: true)
    }
}
