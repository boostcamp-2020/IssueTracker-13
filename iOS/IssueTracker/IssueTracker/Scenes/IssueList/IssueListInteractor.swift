//
//  IssueListInteractor.swift
//  IssueTracker
//
//  Created by 강병민 on 2020/10/28.
//

import Foundation

protocol IssueListBusinessLogic: IssueDataSourceProtocol {
    func fetchIssues()
}

class IssueListInteractor {

    weak var viewController: IssueListDisplayLogic?
    var issueDataSource: IssueDataSourceProtocol?

}

extension IssueListInteractor: IssueListBusinessLogic {

    func fetchIssues() {
        
    }

    func add(issue: Issue) {
    }

    func remove(issue: Issue) {

    }

    func remove(issues: [Issue]) {

    }

    func close(issue: Issue) {

    }

    func close(issues: [Issue]) {

    }

}
