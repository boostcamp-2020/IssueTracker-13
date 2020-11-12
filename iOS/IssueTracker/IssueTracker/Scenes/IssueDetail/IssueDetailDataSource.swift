//
//  IssueDetailDataSource.swift
//  IssueTracker
//
//  Created by 강병민 on 2020/11/11.
//

import Foundation

class IssueDetailDataSource {
    
    enum Section {
        case main
    }
    
    private(set) var comments: [Comment]
    
    init(comments: [Comment]) {
        self.comments = comments
    }
    
    func add(comment: Comment) {
        comments.append(comment)
    }
    
    func update(comment: PutComment) {
        guard let index = comments.firstIndex(where: {$0.id == comment.id}) else { return }
        let oldComment = comments[index]
        let newComment = Comment(id: oldComment.id
                                 ,
                                 description: comment.description,
                                 createdAt: Date().toServerString(),
                                 user: oldComment.user)
        comments[index] = newComment
    }
    
}

