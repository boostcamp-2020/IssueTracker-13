//
//  FilterIssueInteractor.swift
//  IssueTracker
//
//  Created by jaejeon on 2020/11/03.
//

import Foundation

protocol FilterIssueDelegate {

}

protocol FilterIssueBusinessLogic {
    func sendQuery()
}

class FilterIssueInteractor: FilterIssueBusinessLogic {
    var filter: Filter?
    var selectedFilterIndexPath: IndexPath?
    
    weak var viewController: FilterIssueDisplayLogic?
    weak var delegate: IssueListBusinessLogic?
    
    func sendQuery() {
        delegate?.fetchIssues(with: filter)
    }
}

extension FilterIssueInteractor: FilterUserListDelegate {
    
    func didSelect(user: User, mode: FilterUserListInteractor.UserMode) {
        switch mode {
        case .author:
            self.filter?.author = user
            viewController?.didSelectDetailCondition(at: IndexPath(row: 0, section: 1), with: user.userName)
        case .assignee:
            self.filter?.assignee = user
            viewController?.didSelectDetailCondition(at: IndexPath(row: 3, section: 1), with: user.userName)

        }
    }
    
}

extension FilterIssueInteractor: FilterMilestoneListDelegate {
    
    func didSelect(milestone: Milestone) {
        self.filter?.milestone = milestone.title
        viewController?.didSelectDetailCondition(at: IndexPath(row: 2, section: 1), with: milestone.title)
    }
    
}

extension FilterIssueInteractor: FilterLabelListDelegate {
    func didSelect(labels: [Label]) {
        let label = labels.first
        self.filter?.label = label
        viewController?.didSelectDetailCondition(at: IndexPath(row: 1, section: 1), with: label?.title ?? "")
    }
}
