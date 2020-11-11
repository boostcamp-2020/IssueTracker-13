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
    @IBOutlet weak var openedIssuesLabel: UILabel!
    @IBOutlet weak var closedIssuesLabel: UILabel!
    @IBOutlet weak var percentageLabel: UILabel!
    func configure(with milestone: Milestone) {
        titleLabel.configure(with: milestone.title)
        descriptionLabel.text = milestone.description
        dueDateLabel.text = milestone.dueDate?.toDate()?.toCellString()
        closedIssuesLabel.text = "\(milestone.allIssueCount ?? 0 - (milestone.closedIssueCount ?? 0)) opened"
        openedIssuesLabel.text = "\(milestone.closedIssueCount) closed"
        var percentage = 0
        if milestone.allIssueCount != 0 {
            percentage = (milestone.closedIssueCount ?? 0) / (milestone.allIssueCount ?? 0) * 100
        }
        percentageLabel.text = "\(percentage)%"
    }
}
