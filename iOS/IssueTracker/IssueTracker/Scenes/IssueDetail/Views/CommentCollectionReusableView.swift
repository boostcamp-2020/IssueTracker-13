//
//  CommentCollectionReusableView.swift
//  IssueTracker
//
//  Created by 강병민 on 2020/11/11.
//

import UIKit

class CommentCollectionReusableView: UICollectionReusableView {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var issueIDLAbel: UILabel!
    @IBOutlet weak var issueTitleLabel: UILabel!
    @IBOutlet weak var issueIsOpenLAbel: UILabel!
    
    func configure(with issue: Issue) {
        profileImageView.loadImageUsingCache(with: issue.author.profile)
        userNameLabel.text = issue.author.userName
        issueIDLAbel.text = "#\(issue.id)"
        issueTitleLabel.text = issue.title
        issueIsOpenLAbel.text = issue.isOpen ? "Open" : "Close"
        layoutMargins.left = 0
        layoutMargins.right = 0
    }
    
}
