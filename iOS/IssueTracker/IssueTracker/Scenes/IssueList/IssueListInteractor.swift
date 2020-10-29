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
    var issueDataSource: IssueDataSource?
    var worker = IssueWorker()
}

extension IssueListInteractor: IssueListBusinessLogic {

    func fetchIssues() {
        worker.fetchIssues { (dataSource) in
            self.issueDataSource = dataSource
            self.viewController?.displayIssueList(with: dataSource.issues, at: .main)
        }
    }

    func add(issue: Issue) {
        guard let dataSource = issueDataSource else { return }
        dataSource.add(issue: issue)
        self.viewController?.displayIssueList(with: dataSource.issues, at: .main)
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
