//
//  IssueDetailInteractor.swift
//  IssueTracker
//
//  Created by 강병민 on 2020/11/11.
//

import Foundation

protocol IssueDetailBuisnessLogic {
    func fetchComments()
}

class IssueDetailInteractor {
    weak var viewController: IssueDetailDisplayLogic?
    var issueDetailDataSource: IssueDetailDataSource?
    var worker = IssueDetailWorker()
    var issue: Issue?
}

extension IssueDetailInteractor: IssueDetailBuisnessLogic {
    
    func fetchComments() {
        guard let issueID = issue?.id else { return }
        worker.fetchComments(with: issueID) { (dataSource) in
            self.issueDetailDataSource = dataSource
            self.viewController?.displayCommentList(with: dataSource.comments, at: .main)
        }
    }
    
}
