//
//  IssueDetailWorker.swift
//  IssueTracker
//
//  Created by 강병민 on 2020/11/11.
//

import Foundation

class IssueDetailWorker {
    func fetchComments(handler: @escaping (IssueDetailDataSource) -> Void) {

        let user = User(userName: "junsushin-dev",
                        profile: "https://avatars3.githubusercontent.com/u/32405358?s=400&u=cbda272c344b4c9e35cc1ee452f0bc4eae7e34c3&v=4")
        let comments = [Comment(id: 1, description: "레이블 전체 목록을 볼 수 있는게 어떨까요(수정)", createdAt: "2020-11-03T04:35:19.000Z", updatedAt: "2020-11-03T11:59:29.000Z", user: user),
                        Comment(id: 2, description: "싫어요!", createdAt: "2020-11-03T04:35:19.000Z", updatedAt: "2020-11-03T11:59:29.000Z", user: user)
        ]
        
        let dataSource = IssueDetailDataSource(comments: comments)
        handler(dataSource)
        
    }
}
