//
//  IssueListInteractor.swift
//  IssueTracker
//
//  Created by 강병민 on 2020/10/28.
//

import Foundation

protocol IssueListBusinessLogic: class, IssueDataSourceProtocol {
    func fetchIssues(with: Filter?)
}

class IssueListInteractor {

    weak var viewController: IssueListDisplayLogic?
    var issueDataSource: IssueDataSource?
    var worker = IssueWorker()
    var filter: Filter? =  Filter()
}

extension IssueListInteractor: IssueListBusinessLogic {

    func fetchIssues(with filter: Filter? = Filter()) {
        self.filter = filter
        worker.fetchIssues(with: filter?.query ?? "") { (dataSource) in
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
        guard let dataSource = issueDataSource else { return }
        dataSource.remove(issue: issue)
        viewController?.displayIssueList(with: dataSource.openedIssues, at: .main)
    }

    func remove(issues: [Issue]) {
        guard let dataSource = issueDataSource else { return }
        dataSource.remove(issues: issues)
        viewController?.displayIssueList(with: dataSource.openedIssues, at: .main)
    }

    func close(issue: Issue) {
        guard let dataSource = issueDataSource else { return }
        dataSource.close(issue: issue)
        viewController?.displayIssueList(with: dataSource.openedIssues, at: .main)
    }

    func close(issues: [Issue]) {
        guard let dataSource = issueDataSource else { return }
        dataSource.close(issues: issues)
        viewController?.displayIssueList(with: dataSource.openedIssues, at: .main)
    }

}
