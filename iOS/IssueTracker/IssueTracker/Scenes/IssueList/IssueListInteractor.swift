//
//  IssueListInteractor.swift
//  IssueTracker
//
//  Created by 강병민 on 2020/10/28.
//

import Foundation

protocol IssueListBusinessLogic {
    func fetchIssueList()
}

class IssueListInteractor {

    weak var viewController: IssueListDisplayLogic?
    var issueDataSource: IssueDataSource?

}

extension IssueListInteractor: IssueListBusinessLogic {

    func fetchIssueList() {
    }

}
