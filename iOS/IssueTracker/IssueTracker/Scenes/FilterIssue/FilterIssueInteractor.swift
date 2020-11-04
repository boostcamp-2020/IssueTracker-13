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
    
}

class FilterIssueInteractor: FilterIssueBusinessLogic {
    
    var author: User?
    var assignee: User?
    var milestone: String?
    var label: Label?

}

extension FilterIssueInteractor: FilterUserListDelegate {
    
    func didSelect(user: User, mode: FilterUserListInteractor.UserMode) {
        switch mode {
        case .author:
            self.author = user
        case .assignee:
            self.assignee = user
        }
    }
    
}

extension FilterIssueInteractor: FilterMilestoneListDelegate {
    
    func didSelect(milestone: String) {
        self.milestone = milestone
    }
    
}

extension FilterIssueInteractor: FilterLabelListDelegate {
    func didSelect(label: Label) {
        self.label = label
    }
}
