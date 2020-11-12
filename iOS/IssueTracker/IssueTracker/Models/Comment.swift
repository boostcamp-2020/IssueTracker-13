//
//  Comment.swift
//  IssueTracker
//
//  Created by 강병민 on 2020/11/11.
//

import Foundation

struct Comment: Codable, Hashable {
    let id: Int
    let description, createdAt: String
    let user: User

    enum CodingKeys: String, CodingKey {
        case id
        case description, createdAt
        case user = "User"
    }
}
struct PostComment: Codable{
    let issueID: Int
    let description: String
}
