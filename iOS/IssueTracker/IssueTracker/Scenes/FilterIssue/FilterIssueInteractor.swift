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

class FilterIssueInteractor: FilterIssueBusinessLogic, UserListDelegate{
    
    var author: User?
    var assignee: User?

    func didSelect(user: User, mode: UserListInteractor.UserMode) {
        switch mode {
        case .author:
            self.author = user
        case .assignee:
            self.assignee = user
        }
    }
    
}
