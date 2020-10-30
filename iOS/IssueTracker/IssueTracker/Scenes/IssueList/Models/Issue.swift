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
    let milestone: String
    let labels: [Label]
    let author: String
    let assignees: [Assignee]
    let isOpen: Bool
    let createAt: String
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
