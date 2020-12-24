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
    var lessons: [Lesson] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        title = "Lessons"
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "LessonCell", bundle: nil), forCellReuseIdentifier: cellID)
    }
    
}


// MARK: - UITableViewDataSource
extension LessonViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lessons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? LessonCell else {
            return UITableViewCell()
        }
        
        cell.backgroundColor = .clear
        cell.setData(lesson: lessons[indexPath.row])
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
        guard let videoUrl = URL(string: "\(Common.link.streamingVideo)/\(videoName)"), let token = TokenManager.getAccessToken() else {
            return
        }
        let header: [String: String] = ["auth-token": token]
        let asset: AVURLAsset = AVURLAsset.init(url: videoUrl, options: ["AVURLAssetHTTPHeaderFieldsKey": header])
        let playerItem = AVPlayerItem(asset: asset)
        let player = AVPlayer(playerItem: playerItem)
        
        
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        playerViewController.delegate = self
        
        present(playerViewController, animated: true) {
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
                if questions.count != 0 {
                    let questionVC = QuestionVC()
                    questionVC.questions = [questions[0],questions[0],questions[0]]
                    self.navigationController?.pushViewController(questionVC, animated: true)
                    return
                }
            }
        }))
        
        //-- Documents
        alert.addAction(UIAlertAction(title: "Documents", style: .default, handler: { (action) in
            let documentsVC = DocumentsVC()
            documentsVC.documents = self.lessons[indexPath.row].doc
            self.navigationController?.pushViewController(documentsVC, animated: true)
        }))
        
        
        //-- Edit
        alert.addAction(UIAlertAction(title: "Edit", style: .default, handler: { (action) in
            
        }))
        
        //-- Delete
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { (action) in
            
        }))
        
        // Cancel
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
        
    }
}

// MARK: - AVPlayerViewControllerDelegate
extension LessonViewController: AVPlayerViewControllerDelegate {
    
}

