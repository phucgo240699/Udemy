//
//  LessonCell.swift
//  Udemy
//
//  Created by Phúc Lý on 17/12/2020.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import UIKit

protocol LessonCellProtocol: class {
    func onTapQuestion(indexPath: IndexPath?)
    func onTapDocument()
}

class LessonCell: UITableViewCell {

    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var container: UIView!
    
    var indexPath: IndexPath?
    
    weak var delegate: LessonCellProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    private func setupUI() {
        lbTitle.afterEffect(cornerRadius: 10, borderWidth: 0, borderColor: .clear)
        container.afterEffect(cornerRadius: 10, borderWidth: 0, borderColor: .clear)
        container.dropShadow(color: .lightGray, opacity: 0.5, offSet: CGSize(width: 3.0, height: 3.0), radius: 5.0, scale: false)
    }
    
    func setData(lesson: Lesson) {
        lbTitle.text = lesson.title
    }
    @IBAction func questionBtnPressed(_ sender: UIButton) {
        delegate?.onTapQuestion(indexPath: indexPath)
    }
    @IBAction func documentBtnPressed(_ sender: UIButton) {
        delegate?.onTapDocument()
    }
}
