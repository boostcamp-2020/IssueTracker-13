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
    
    func add(comment: PostComment) {
        guard let dataSource = issueDetailDataSource else { return }
        let newID = dataSource.comments.count + 1
        let currentUser = getCurrentUser()
        let newComment = Comment(id: newID,
                                 description: comment.description,
                                 createdAt: Date().toServerString(),
                                 user: currentUser)
        dataSource.add(comment: newComment)
        viewController?.displayCommentList(with: dataSource.comments, at: .main)
    }
    
    func update(comment: PutComment) {
        guard let dataSource = issueDetailDataSource else { return }
        dataSource.update(comment: comment)
        viewController?.displayCommentList(with: dataSource.comments, at: .main)
    }
    
    func getCurrentUser() -> User {
        let userToken = UserToken()
        return User(userName: userToken.name, profile: userToken.profile)
    }
}

extension IssueDetailInteractor: IssueEditDelegate {
    
    func didTouchSendButton(titleText: String?, previewText: String?, commentID: Int?) {
        guard let issueID = issue?.id,
              let description = previewText else { return }
        // 수정할떄
        if let commentID = commentID {
            let putComment = PutComment(description: description, id: commentID)
            API.shared.put(data: putComment, to: .comments, completion: { (result) in
                switch result {
                case .success:
                    self.update(comment: putComment)
                case .failure:
                    print("failure")
                }
            })
        } else { // 추가할떄
            let postComment = PostComment(description: description, issueID: issueID)
            API.shared.post(data: postComment, to: .comments, completion: { (result: Result<Response, Error>) in
                switch result {
                case .success:
                    self.add(comment: postComment)
                case .failure:
                    print("failure")
                }
            })
        }
        
    }
    
}
