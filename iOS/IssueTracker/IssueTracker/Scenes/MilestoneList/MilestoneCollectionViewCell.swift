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
        guard let allIssueCount = milestone.allIssueCount,
              let closedIssueCount = milestone.closedIssueCount else {return}
        titleLabel.configure(with: milestone.title)
        descriptionLabel.text = milestone.description
        dueDateLabel.text = milestone.dueDate?.toDate()?.toCellString()
        
        closedIssuesLabel.text = "\(allIssueCount - closedIssueCount) opened"
        openedIssuesLabel.text = "\(closedIssueCount) closed"
        var percentage: Double = 0
        if milestone.allIssueCount != 0 {
            percentage = Double(closedIssueCount) / Double(allIssueCount) * 100.0
        }
        percentageLabel.text = "\(Int(percentage))%"
    }
}
