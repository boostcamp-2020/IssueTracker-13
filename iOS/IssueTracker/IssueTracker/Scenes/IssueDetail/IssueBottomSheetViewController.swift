//
//  IssueBottomSheetViewController.swift
//  IssueTracker
//
//  Created by jaejeon on 2020/11/11.
//

import UIKit

protocol IssueBottomSheetDisplayLogic: class {
    func configureBottomSheet(issue: Issue)
}

class IssueBottomSheetViewController: UIViewController {
    @IBOutlet weak var userNameLabel: UILabel!    
    @IBOutlet weak var userProfileImageView: UIImageView!
    @IBOutlet weak var milestone: MilestoneBadgeLabel!
    @IBOutlet weak var labelStackView: UIStackView!
    var interactor: IssueBottomSheetInteractor?
    
    init?(coder: NSCoder, issue: Issue?) {
        self.interactor = IssueBottomSheetInteractor(with: issue)
        super.init(coder: coder)
    }   
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.interactor?.vc = self
        guard let issue = interactor?.issue else { return }
        configureBottomSheet(issue: issue)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if segue.identifier == "showLabelEdit" {
            guard let vc = segue.destination as? FilterLabelListViewController else { return }
            vc.mode = .edit
            vc.labels = self.interactor?.issue?.labels
            vc.interactor.delegate = self.interactor
        } else if segue.identifier == "showMilestoneEdit" {
            guard let vc = segue.destination as? FilterMilestoneListViewController else { return }
//            vc.mode = .edit
//            vc.labels = self.interactor ?.issue?.labels
            vc.interactor.delegate = self.interactor
        }
    }
}

extension IssueBottomSheetViewController: IssueBottomSheetDisplayLogic {
    func configureBottomSheet(issue: Issue) {
        self.userNameLabel.text = issue.author.userName
        self.userProfileImageView.loadImageUsingCache(with: issue.author.profile)
        self.milestone.configure(with: issue.milestone.title)
        self.labelStackView.subviews.forEach({$0.removeFromSuperview()})
        issue.labels.forEach { (label) in
            let newLabel = LabelBadgeLabel()
            newLabel.configure(with: label)
            labelStackView.addArrangedSubview(newLabel)
        }
    }
}
