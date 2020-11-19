//
//  SearchSuggestionCell.swift
//  Udemy
//
//  Created by Phúc Lý on 18/11/2020.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import UIKit

class Row {
    var attributes = [UICollectionViewLayoutAttributes]()
    var spacing: CGFloat = 0

    init(spacing: CGFloat) {
        self.spacing = spacing
    }

    func add(attribute: UICollectionViewLayoutAttributes) {
        attributes.append(attribute)
    }

    func tagLayout(collectionViewWidth: CGFloat) {
        let padding = 10
        var offset = padding
        for attribute in attributes {
            attribute.frame.origin.x = CGFloat(offset)
            offset += Int(attribute.frame.width + spacing)
        }
    }
}

class TagFlowLayout: UICollectionViewFlowLayout {
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let attributes = super.layoutAttributesForElements(in: rect) else {
            return nil
        }

        var rows = [Row]()
        var currentRowY: CGFloat = -1

        for attribute in attributes {
            if currentRowY != attribute.frame.origin.y {
                currentRowY = attribute.frame.origin.y
                rows.append(Row(spacing: 10))
            }
            rows.last?.add(attribute: attribute)
        }

        rows.forEach { $0.tagLayout(collectionViewWidth: collectionView?.frame.width ?? 0) }
        return rows.flatMap { $0.attributes }
    }
}

fileprivate let cellID = "searchSuggestionCLVCell"

class SearchSuggestionCell: UITableViewCell {
    
    // Closure
    var onTapTagCell: ((String) -> Void)?

    @IBOutlet weak var collectionView: UICollectionView!
    
    var titles: [String] = [ "lap trinh", "thpt", "java", "adobe", "javascript", "toan",  "van", "am nhac", "ngoai ngu", "tieng anh", "tieng nhat", "IELTS" ]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupUI() {
        let layout = TagFlowLayout()
        layout.estimatedItemSize = CGSize(width: 140, height: 33)
        collectionView.collectionViewLayout = layout
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "TagCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: cellID)
    }
}

// MARK: - UICollectionViewDatasource, UICollectionViewDelegateFlowLayout
extension SearchSuggestionCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as? TagCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.setData(title: titles[indexPath.row])
        cell.lbTitle.preferredMaxLayoutWidth = collectionView.frame.width
        
        return cell
    }
    
    
}


// MARK: - UICollectionViewDelegate
extension SearchSuggestionCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let onTapTagCell = onTapTagCell {
            onTapTagCell(titles[indexPath.row])
        }
    }
}
