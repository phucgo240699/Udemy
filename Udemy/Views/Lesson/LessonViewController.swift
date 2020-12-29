//
//  LessonViewController.swift
//  Udemy
//
//  Created by Phúc Lý on 17/12/2020.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import UIKit
import AVKit

fileprivate let cellID = "lessonCell"

class LessonViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lbEmpty: UILabel!
    var addBarButton: UIBarButtonItem?
    var refreshControl: UIRefreshControl = UIRefreshControl()
    
    var playerViewController: AVPlayerViewController?
    
    var idCourse: String?
    var lessons: [Lesson] = []
    var currentLesson: Lesson?
    var displayLessons: [Lesson] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        adaptData()
    }
    
    private func setupUI() {
        
        self.enableTapToDismiss()
        
        //-- Navigation
        title = "Lessons"
        addBarButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(LessonViewController.addLessonBarBtnPressed(_:)))
        navigationItem.rightBarButtonItem = addBarButton
        
        
        //-- TableView
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "LessonCell", bundle: nil), forCellReuseIdentifier: cellID)
        
        // refresh control
        refreshControl.addTarget(self, action: #selector(CourseViewController.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
        
    }
    
    @objc func refresh(_ sender: UIRefreshControl) {
        refreshControl.endRefreshing()
        
        adaptData()
    }
    
    // MARK: Handle Event
    @objc func addLessonBarBtnPressed(_ sender: UIBarButtonItem) {
        let createLessonVC = CreateLessonVC()
        createLessonVC.idCourse = idCourse
        createLessonVC.order = 1
        createLessonVC.delegate = self
        navigationController?.pushViewController(createLessonVC, animated: true)
    }
    
    func handleEmptyData() {
        if self.lessons.count == 0 {
            self.tableView.isHidden = true
            self.lbEmpty.isHidden = false
        }
        else {
            self.tableView.isHidden = false
            self.lbEmpty.isHidden = true
        }
    }
    
    func adaptData() {
        RequestAPI.shared.fetchLessons(idCourse: idCourse) { (lessons) in
            self.lessons = lessons
            
            self.displayLessons = lessons
            
            self.handleEmptyData()
            
            self.tableView.reloadData()
        }
    }
    
    @objc func playerDidFinishPlaying(note: NSNotification) {
        RequestAPI.shared.updateProgressLesson(idCourse: idCourse, idLesson: currentLesson?._id) {
            self.dismiss(animated: true, completion: nil)
        }
    }
}


// MARK: - UITableViewDataSource
extension LessonViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let searchBar = UISearchBar()
        searchBar.delegate = self
        return searchBar
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayLessons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? LessonCell else {
            return UITableViewCell()
        }
        
        cell.backgroundColor = .clear
        cell.setData(lesson: displayLessons[indexPath.row])
        cell.indexPath = indexPath
        cell.delegate = self
        
        return cell
    }
    
    
}


// MARK: - UITableViewDelegate
extension LessonViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let videoName = self.lessons[indexPath.row].video else {
            return
        }
        guard let videoUrl = URL(string: "\(Common.link.streamingVideo)/\(videoName.split(separator: " ").joined(separator: "%20"))"), let token = TokenManager.getAccessToken() else {
            return
        }
        let header: [String: String] = ["auth-token": token]
        let asset: AVURLAsset = AVURLAsset.init(url: videoUrl, options: ["AVURLAssetHTTPHeaderFieldsKey": header])
        let playerItem = AVPlayerItem(asset: asset)
        let player = AVPlayer(playerItem: playerItem)
        
        
        playerViewController = AVPlayerViewController()
        
        guard let playerViewController = playerViewController else {
            return
        }
        
        playerViewController.player = player
        
        NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying), name: .AVPlayerItemDidPlayToEndTime, object: nil)
        
        present(playerViewController, animated: true) {
            self.currentLesson = self.lessons[indexPath.row]
            player.play()
        }
    }
}


// MARK: - Cell Delegate
extension LessonViewController: LessonCellProtocol {
    func onTapOptionBtn(indexPath: IndexPath) {
        let alert = UIAlertController(title: "Choose your action", message: "", preferredStyle: .actionSheet)
        
        //-- Questions
        alert.addAction(UIAlertAction(title: "Questions", style: .default, handler: { (action) in
            if let questions = self.lessons[indexPath.row].popupQuestion {
                let questionVC = QuestionVC()
                questionVC.questions = questions
                self.navigationController?.pushViewController(questionVC, animated: true)
            }
            return
        }))
        
        //-- Documents
        alert.addAction(UIAlertAction(title: "Documents", style: .default, handler: { (action) in
            if let documents = self.lessons[indexPath.row].doc {
                let documentsVC = DocumentsVC()
                documentsVC.documents =  documents
                self.navigationController?.pushViewController(documentsVC, animated: true)
            }
        }))
        
        
        //-- Mark as Complete
        alert.addAction(UIAlertAction(title: "Mark as Complete", style: .default, handler: { (action) in
            RequestAPI.shared.updateProgressLesson(idCourse: self.idCourse, idLesson: self.lessons[indexPath.row]._id) {
                self.notificate(UIImage(named: Common.imageName.done), "Congratulate", "You completed this lesson")
            }
        }))
        
        //-- Edit
        alert.addAction(UIAlertAction(title: "Edit", style: .default, handler: { (action) in
            let createLessonVC = CreateLessonVC()
            createLessonVC.delegate = self
            createLessonVC.isEditForm = true
            createLessonVC.id = self.lessons[indexPath.row]._id
            createLessonVC.titleCourse = self.lessons[indexPath.row].title
            createLessonVC.idCourse = self.idCourse
            createLessonVC.order = 1
            createLessonVC.indexPath = indexPath
            self.navigationController?.pushViewController(createLessonVC, animated: true)
        }))
        
        //-- Delete
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { (action) in
            RequestAPI.shared.deleteLesson(by: self.lessons[indexPath.row]._id) {
                self.lessons.remove(at: indexPath.row)
                self.displayLessons.remove(at: indexPath.row)
                
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        }))
        
        // Cancel
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
        
    }
}


// MARK: Create Lesson Delegate
extension LessonViewController: CreateLessonVCDelegate {
    func didCreateLessonSuccess(lesson: Lesson) {
        self.lessons.append(lesson)
        
        self.tableView.beginUpdates()
        self.tableView.endUpdates()
        self.tableView.insertRows(at: [IndexPath(row: self.lessons.count - 2, section: 0)], with: .automatic)
    }
    
    func didUpdateLessonSuccess(lesson: Lesson, indexPath: IndexPath) {
        self.lessons[indexPath.row].title = lesson.title
        (self.tableView.cellForRow(at: indexPath) as? LessonCell)?.lbTitle.text = lesson.title
    }
}


// MARK: Search Delegate
extension LessonViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmptyOrSpacing() {
            displayLessons = lessons
        }
        else {
            displayLessons = lessons.filter({ (lesson) -> Bool in
                return lesson.title?.lowercased().contains(searchText.lowercased()) ?? false
            })
        }
        
        UIView.animate(withDuration: 0.5) {
            self.tableView.reloadData()
        }
    }
}
