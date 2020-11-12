//
//  CommentCollectionViewCell.swift
//  IssueTracker
//
//  Created by 강병민 on 2020/11/11.
//

import UIKit
import MarkdownKit

class CommentCollectionViewCell: UICollectionViewListCell {
    
    var didTouchMenuButton: ((Int) -> Void)?
    var commentID: Int?
    let markdownParser = MarkdownParser(font: UIFont.systemFont(ofSize: CGFloat(17)))

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var updatedTimeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var moreButton: UIButton!
    func confiugre(with comment: Comment) {
        profileImageView.loadImageUsingCache(with: comment.user.profile)
        updatedTimeLabel.text = timeDifference(from: comment.createdAt.toDate() ?? Date())
        userNameLabel.text = comment.user.userName
        descriptionLabel.attributedText = markdownParser.parse(comment.description)
        commentID = comment.id
    }
    
    @IBAction func didTouchMenuButton(_ sender: Any) {
        guard let commentID = commentID else { return }
        didTouchMenuButton?(commentID)
    }
    
    func timeDifference(from: Date) -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        let relativeDate = formatter.localizedString(for: from, relativeTo: Date())
        return relativeDate
    }
    
    func configureButton(with comment: Comment) {
        let userToken = UserToken()
        if comment.user.userName == userToken.name{
            moreButton.isHidden = false
        } else {
            moreButton.isHidden = true
        }
    }
        
}
