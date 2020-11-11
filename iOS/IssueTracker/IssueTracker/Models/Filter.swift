//
//  Filter.swift
//  IssueTracker
//
//  Created by jaejeon on 2020/11/10.
//

import Foundation

struct Filter {
    var author: User?
    var assignee: User?
    var milestone: String?
    var label: Label?
    var isOpen: Bool
    var commentor: User?
    
    var query: String {
        var query = "?"
        query += "isOpen=\(isOpen)&"
        if let author = author {
            query += "author=\(author.userName)&"
        }
        if let label = label {
            query += "label=\(label.title ?? "")&"
        }
        if let milestone = milestone {
            query += "milestone=\(milestone)&"
        }
        if let commentor = commentor {
            query += "commentor=\(commentor)&"
        }
        if let assignee = assignee {
            query += "assignee=\(assignee)&"
        }
        query.removeLast()
        return query
    }
}
