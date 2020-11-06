//
//  MileStoneCollectionViewCell.swift
//  IssueTracker
//
//  Created by jaejeon on 2020/11/06.
//

import UIKit

class MilestoneCollectionViewCell: UICollectionViewListCell {
    @IBOutlet weak var titleLabel: MilestoneBadgeLabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dueDateLabel: UILabel!
    func configure(with milestone: Milestone) {
        titleLabel.configure(with: milestone.title)
        descriptionLabel.text = milestone.description
        dueDateLabel.text = milestone.dueDate
    }
}
