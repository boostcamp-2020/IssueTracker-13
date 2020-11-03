//
//  IssueCollectionViewCell.swift
//  IssueTracker
//
//  Created by 강병민 on 2020/10/28.
//

import UIKit

class IssueCollectionViewCell: UICollectionViewListCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var previewLabel: UILabel!
    @IBOutlet weak var milestoneBadgeLabel: MilestoneBadgeLabel!
    @IBOutlet weak var labelBadgeLabel: LabelBadgeLabel!
    
    func configure(with issue: Issue) {
        titleLabel.text = issue.title
        previewLabel.text = issue.preview
        milestoneBadgeLabel.configure(with: issue.milestone)
        labelBadgeLabel.configure(with: issue.labels.first?.title ?? "", color: "", backgroundColor: "")
//        contentConfiguration = defaultContentConfiguration()
        separatorLayoutGuide.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        accessories = [.multiselect(displayed: .whenEditing, options: .init())]
    }

}
