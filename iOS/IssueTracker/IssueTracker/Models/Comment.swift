//
//  Comment.swift
//  IssueTracker
//
//  Created by 강병민 on 2020/11/11.
//

import Foundation

struct Comment: Codable {
    let id: Int
    let description, createdAt, updatedAt: String
    let user: User

    enum CodingKeys: String, CodingKey {
        case id
        case description, createdAt, updatedAt
        case user = "User"
    }
}

class IssueDetailDataSource {
    
    enum Section {
        case main
    }
    
    private(set) var comments: [Comment]
    
    init(comments: [Comment]) {
        self.comments = comments
    }
    
}
