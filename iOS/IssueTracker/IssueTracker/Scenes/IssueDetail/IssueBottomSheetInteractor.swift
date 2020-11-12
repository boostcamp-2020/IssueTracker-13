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
    init(with issue: Issue?) {
        self.issue = issue
    }
}

extension IssueBottomSheetInteractor: FilterLabelListDelegate {
    func didSelect(labels: [Label]) {
        issue?.labels = labels
        guard let issue = self.issue else { return }
        vc?.configureBottomSheet(issue: issue)
    }
}
