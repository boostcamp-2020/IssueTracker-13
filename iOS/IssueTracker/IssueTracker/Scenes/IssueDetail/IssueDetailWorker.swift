//
//  IssueDetailWorker.swift
//  IssueTracker
//
//  Created by 강병민 on 2020/11/11.
//

import Foundation

class IssueDetailWorker {
    
    func fetchComments(with id: Int, handler: @escaping (IssueDetailDataSource) -> Void) {

        API.shared.get(with: "?issueId=\(id)", from: .comments) { (result: Result<[Comment], Error>) in
            switch result {
            case .success(let comments):
                let dataSource = IssueDetailDataSource(comments: comments)
                handler(dataSource)
            case .failure:
                break
            }
        }
    }
    
}
