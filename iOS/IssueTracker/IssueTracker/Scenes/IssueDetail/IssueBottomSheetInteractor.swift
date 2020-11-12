//
//  IssueBottomSheetInteractor.swift
//  IssueTracker
//
//  Created by jaejeon on 2020/11/12.
//

import Foundation

protocol IssueBottomSheetBusinessLogic {
    var issue: Issue? {get set}
}

class IssueBottomSheetInteractor: IssueBottomSheetBusinessLogic {
    var issue: Issue?
    var vc: IssueBottomSheetDisplayLogic?
    var worker: IssueEditWorker?
    init(with issue: Issue?) {
        self.issue = issue
        self.worker = IssueEditWorker()
    }
}

extension IssueBottomSheetInteractor: FilterLabelListDelegate {
    func didSelect(labels: [Label]) {
        issue?.labels = labels
        guard let issue = self.issue else { return }
        vc?.configureBottomSheet(issue: issue)
        worker?.update(issue: issue)
    }
}

extension IssueBottomSheetInteractor: FilterMilestoneListDelegate {
    func didSelect(milestone: Milestone?) {
        issue?.milestone = milestone
        guard let issue = self.issue else { return }
        vc?.configureBottomSheet(issue: issue)
        worker?.update(issue: issue)
    }
}
