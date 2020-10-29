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
    @IBOutlet weak var milestoneLabel: UILabel!
    @IBOutlet weak var labelLabel: UILabel!
    
    func configure(with issue: Issue) {
        titleLabel.text = issue.title
        previewLabel.text = issue.preview
        milestoneLabel.text = issue.milestone
        labelLabel.text = issue.label
    }

}
