//
//  LabelCollectionViewCell.swift
//  IssueTracker
//
//  Created by jaejeon on 2020/11/05.
//

import UIKit

class LabelCollectionViewCell: UICollectionViewListCell {
    
    @IBOutlet weak var titleLabel: LabelBadgeLabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    func configure(with label: Label) {
        titleLabel.text = label.title
        descriptionLabel.text = label.description
        accessories = [.disclosureIndicator()]
    }
}
