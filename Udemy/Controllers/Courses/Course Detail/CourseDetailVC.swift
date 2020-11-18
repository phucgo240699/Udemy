//
//  CourseDetailVC.swift
//  Udemy
//
//  Created by Phúc Lý on 15/11/2020.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import UIKit

fileprivate let bannerInfoCellID = "courseDetailBannerInfoCell"
fileprivate let operationCellID = "courseDetailOperationCell"
fileprivate let descriptionCellID = "courseDetailDescriptionCell"
fileprivate let relatedCoursesCellID = "courseDetailRelatedCourses"

enum CourseDetailCellType: Int {
    case BannerInfo = 0
    case Operation = 1
    case Description = 2
    case RelatedCourses = 3
}

class CourseDetailVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let cellTypes: [CourseDetailCellType] = [ .BannerInfo, .Operation, .Description, .RelatedCourses ]
    
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
    var courseId: String?
    var categoryId: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationItem.title = "Detail"
        navigationController?.navigationBar.isHidden = false
        
        setupUI()
        
//        fetCourseDetail(by: courseId)
        fetchRelatedCourses(by: categoryId)
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
        case.Description:
            return UITableView.automaticDimension
        default:
            return 368.0
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellTypes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        switch cellTypes[indexPath.row] {
        case .BannerInfo:
            let cell = self.tableView.dequeueReusableCell(withIdentifier: bannerInfoCellID, for: indexPath) as! CourseDetailBannerInfoCell
            cell.setData(course: course)
            return cell
        case .Operation:
            let cell = self.tableView.dequeueReusableCell(withIdentifier: operationCellID, for: indexPath) as! CourseDetailOperationCell
            cell.isJoinedCourse = isJoinedCourse
            cell.onTapJoinCourseBtn = {
                self.joinCourse(idUser: self.course?.idUser?._id, idCourse: self.course?._id)
            }
            cell.onTapAddToCartBtn = {
                if let course = self.course {
                    (UIApplication.shared.delegate as? AppDelegate)?.cart.courses.append(course)
                    (UIApplication.shared.delegate as? AppDelegate)?.window?.notificate(UIImage(named: Common.imageName.done), "Add to cart successfully", "")
                }
            }
            cell.onTapSendRatingBtn = { numStar in
                self.sendRating(numStar: numStar, idUser: self.course?.idUser?._id, idCourse: self.course?._id)
            }
            
            cell.setData(course: course)
            return cell
        case .Description:
            let cell = self.tableView.dequeueReusableCell(withIdentifier: descriptionCellID, for: indexPath) as! CourseDetailDescriptionCell
            cell.setData(course: course)
            return cell
        case .RelatedCourses:
            let cell = self.tableView.dequeueReusableCell(withIdentifier: relatedCoursesCellID, for: indexPath) as! CourseDetailRelatedCoursesCell
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
        tableView.register(UINib(nibName: "CourseDetailRelatedCoursesCell", bundle: nil), forCellReuseIdentifier: relatedCoursesCellID)
    }
}
