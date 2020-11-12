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
    @IBOutlet weak var labelStackView: UIStackView!
    
    func configure(with issue: Issue) {
        titleLabel.text = issue.title
        previewLabel.text = issue.preview.isEmpty ? " " : issue.preview
        milestoneBadgeLabel.configure(with: issue.milestone?.title ?? "")
//        if let firstLabel = issue.labels.first {
//            labelBadgeLabel.configure(with: firstLabel)
//        }
        configure(labelStackView, with: issue.labels)
        print("\(issue.title) : \(issue.labels.count)")
        
        separatorLayoutGuide.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        accessories = [.multiselect(displayed: .whenEditing, options: .init())]
    }
    
    func configure(_ stackview: UIStackView, with labels: [Label]) {
        labelStackView.subviews.forEach({$0.removeFromSuperview()})
        labels.forEach { (label) in
            let newLabel = LabelBadgeLabel()
            newLabel.configure(with: label)
            labelStackView.addArrangedSubview(newLabel)
        }
    }

}
