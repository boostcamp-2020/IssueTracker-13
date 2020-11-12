//
//  Issue.swift
//  IssueTracker
//
//  Created by 강병민 on 2020/10/28.
//

import Foundation

struct Issue: Codable {
    let id: Int
    let title: String
    let preview: String
    var milestone: Milestone?
    var labels: [Label]
    let author: User
    let assignees: [User]
    var isOpen: Bool
    let createAt: String?
    
    enum CodingKeys : String, CodingKey{
        case id, title, preview, author, isOpen, createAt
        case milestone = "Milestone"
        case assignees = "Assignee"
        case labels = "Labels"
    }
}

extension Issue: Hashable {
    static func == (lhs: Issue, rhs: Issue) -> Bool {
        lhs.hashValue == rhs.hashValue
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(title)
        hasher.combine(preview)
    }
    
}
