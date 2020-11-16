//
//  CourseDetailRelatedCourses.swift
//  Udemy
//
//  Created by Phúc Lý on 16/11/2020.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import UIKit

class CourseDetailRelatedCoursesCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var courses: [Course] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupUI() {
        //-- Collection View
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CourseCollectionViewCell.self, forCellWithReuseIdentifier: "relatedCourses")
    }
    
}

// MARK: UICollectionView Datasource
extension CourseDetailRelatedCoursesCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 280)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return courses.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "relatedCourses", for: indexPath) as! CourseCollectionViewCell
        
        cell.fillData(courses[indexPath.row])
        
        return cell
    }
    
    
}

// MARK: UICollectionView Delegate
extension CourseDetailRelatedCoursesCell: UICollectionViewDelegate {
    
}
