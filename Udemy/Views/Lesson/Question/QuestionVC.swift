//
//  QuestionVC.swift
//  Udemy
//
//  Created by Phúc Lý on 24/12/2020.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import UIKit

fileprivate let answerCellID = "answer cell"
fileprivate let imageCellID = "image cell"

class QuestionVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var currentSelectedIndex: IndexPath?
    
    var question: LessonChoice?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    private func setupUI() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: answerCellID)
        tableView.register(UINib(nibName: "ImageCell", bundle: nil), forCellReuseIdentifier: imageCellID)
        
    }

}

// MARK: - UITableViewDataSource
extension QuestionVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25.0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let questionTitle = question?.question else {
            return "Question: "
        }
        return "Question: \(questionTitle)"
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 20.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: imageCellID, for: indexPath) as? ImageCell, let imageQuestion = question?.image else {
                return UITableViewCell()
            }
            cell.imgView.sd_setImage(with: URL(string: "\(Common.link.getImage)/\(imageQuestion)"), completed: nil)
            
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: answerCellID, for: indexPath)
        cell.selectionStyle = .none
        
        guard let answerA = question?.A,
              let answerB = question?.B,
              let answerC = question?.C,
              let answerD = question?.D else {
            return UITableViewCell()
        }
        switch indexPath.row {
        case 1:
            cell.textLabel?.text = "A: \(answerA)"
        case 2:
            cell.textLabel?.text = "B: \(answerB)"
        case 3:
            cell.textLabel?.text = "C: \(answerC)"
        default:
            cell.textLabel?.text = "D: \(answerD)"
        }
        
        return cell
    }
    
    
}

// MARK: - UITableViewDelegate
extension QuestionVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let currentSelectedIndex = currentSelectedIndex {
            tableView.cellForRow(at: currentSelectedIndex)?.accessoryType = .none
        }
        
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        
        currentSelectedIndex = indexPath
    }
}
