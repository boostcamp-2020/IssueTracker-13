//
//  IssueBottomSheetViewController.swift
//  IssueTracker
//
//  Created by jaejeon on 2020/11/11.
//

import UIKit

class IssueBottomSheetViewController: UIViewController {
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var label: LabelBadgeLabel!
    
    @IBOutlet weak var userProfileImageView: UIImageView!
    @IBOutlet weak var milestone: MilestoneBadgeLabel!
    var issue: Issue?
    init?(coder: NSCoder, issue: Issue?) {
        self.issue = issue
        super.init(coder: coder)
    }   
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    func configure() {
        self.userNameLabel.text = issue?.author.userName
        guard let label = issue?.labels.first else { return }
        self.label.configure(with: label)
        guard let milestone = issue?.milestone else { return }
        self.milestone.configure(with: milestone.title)
    }
}
