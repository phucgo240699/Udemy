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
    @IBOutlet weak var lbEmpty: UILabel!
    var submitBarBtn: UIBarButtonItem?
    
    
    var answers: [Int] = []
    var questions: [LessonQuestion] = [] {
        didSet {
            answers = []
            for _ in questions {
                answers.append(-1)
            }
        }
    }
    var isSubmit: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        handleEmptyData()
    }

    private func setupUI() {
        
        submitBarBtn = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(QuestionVC.submitBarBtnPressed(_:)))
        submitBarBtn?.isEnabled = false
        navigationItem.title = "Questions"
        navigationItem.rightBarButtonItem = submitBarBtn
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: answerCellID)
        tableView.register(UINib(nibName: "ImageCell", bundle: nil), forCellReuseIdentifier: imageCellID)
    }
    
    @objc func submitBarBtnPressed(_ sender: UIBarButtonItem) {
        isSubmit = true
        
        self.tableView.reloadData()
    }
    
    func handleEmptyData() {
        if questions.count == 0 {
            tableView.isHidden = true
            lbEmpty.isHidden = false
        }
        else {
            tableView.isHidden = false
            lbEmpty.isHidden = true
        }
    }
}

// MARK: - UITableViewDataSource
extension QuestionVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 20.0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let questionTitle = questions[section].question else {
            return "Question \(section): "
        }
        return "Question \(section): \(questionTitle)"
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return questions.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: imageCellID, for: indexPath) as? ImageCell, let imageQuestion = questions[indexPath.section].image else {
                return UITableViewCell()
            }
            
            if isSubmit {
                cell.imgCheck.isHidden = false
                if answers[indexPath.section] == 1 {
                    cell.imgCheck.image = UIImage(named: Common.imageName.done)
                }
                else {
                    cell.imgCheck.image = UIImage(named: Common.imageName.xRedMark)
                }
            }
            else {
                cell.imgCheck.isHidden = true
            }
            
            cell.imgView.sd_setImage(with: URL(string: "\(Common.link.getLessonSource)/\(imageQuestion)"), completed: nil)
            
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: answerCellID, for: indexPath)
        cell.selectionStyle = .none
        
        guard let answerA = questions[indexPath.section].A,
              let answerB = questions[indexPath.section].B,
              let answerC = questions[indexPath.section].C,
              let answerD = questions[indexPath.section].D else {
            return UITableViewCell()
        }
        switch indexPath.row {
        case 1:
            cell.textLabel?.text = "A. \(answerA)"
        case 2:
            cell.textLabel?.text = "B. \(answerB)"
        case 3:
            cell.textLabel?.text = "C. \(answerC)"
        default:
            cell.textLabel?.text = "D. \(answerD)"
        }
        
        return cell
    }
    
    
}

// MARK: - UITableViewDelegate
extension QuestionVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var currentIndexAnswer = indexPath.row
        if currentIndexAnswer == 0 { // image cell
            return
        }
        else {
            currentIndexAnswer -= 1
        }
        
        submitBarBtn?.isEnabled = true
        
        if questions[indexPath.section].getAnswerIndex() == currentIndexAnswer {
            answers[indexPath.section] = 1
        }
        else {
            answers[indexPath.section] = -1
        }
        
        for i in 0..<4 {
            self.tableView.cellForRow(at: IndexPath(row: i, section: indexPath.section))?.accessoryType = .none
        }
        self.tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
    }
}
