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
        
    }

    func add(issue: PostIssue) {
        guard let dataSource = issueDataSource else { return }
        let newID = dataSource.issues.count + 1
        let newIssue = Issue(id: newID,
                             title: issue.title,
                             preview: issue.comment,
                             milestone: nil, labels: [],
                             author: getCurrentUser(),
                             assignees: [],
                             isOpen: true,
                             createAt: Date().toServerString())
        dataSource.add(issue: newIssue)
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
        API.shared.put(data: ["id": [issue.id], "isOpen": false], to: .issues) { (result) in
            print(result)
        }
    }

    func close(issues: [Issue]) {
        guard let dataSource = issueDataSource else { return }
        dataSource.close(issues: issues)
        viewController?.displayIssueList(with: dataSource.openedIssues, at: .main)
        API.shared.put(data: ["id": issues.map({ $0.id }), "isOpen": false], to: .issues) { (result) in
            print(result)
        }
    }

    func getCurrentUser() -> User {
        let userToken = UserToken()
        return User(id: nil, userName: userToken.name, profile: userToken.profile)
    }
    
}

extension IssueListInteractor: IssueEditDelegate {
    
    func didTouchSendButton(titleText: String?, previewText: String?, commentID: Int?) {
        guard let titleText = titleText,
              let comment = previewText else { return }
        
        let postIssue = PostIssue(title: titleText, comment: comment)
        
        API.shared.post(data: postIssue, to: .issues, completion: { (result: Result<Response, Error>) in
            switch result {
            case .success:
                self.add(issue: postIssue)
            case .failure:
                print("failure")
            }
        })
    }
    
}
