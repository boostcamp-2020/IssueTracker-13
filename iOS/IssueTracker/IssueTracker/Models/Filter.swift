//
//  Filter.swift
//  IssueTracker
//
//  Created by jaejeon on 2020/11/10.
//

import Foundation

struct Filter {
    var author: String?
    var assignee: String?
    var milestone: Milestone?
    var label: Label?
    var isOpen: Bool
    var commentator: String?
    var selectedIndexPath: IndexPath?
    
    init() {
        self.selectedIndexPath = IndexPath(row: 0, section: 0)
        self.isOpen = true
    }
    
    var query: String {
        var query = "?"
        query += "isOpen=\(isOpen)&"
        if let author = author {
            query += "author=\(author)&"
        }
        if let label = label {
            query += "label=\(label.title ?? "")&"
        }
        if let milestone = milestone {
            query += "milestone=\(milestone.title)&"
        }
        if let commentor = commentator {
            query += "commentator=\(commentor)&"
        }
        if let assignee = assignee {
            query += "assignee=\(assignee)&"
        }
        query.removeLast()
        return query
    }
    
    mutating func chagne(indexPath: IndexPath) {
        self.selectedIndexPath = indexPath

        switch indexPath.row {
        case 0:
            self.isOpen = true
        case 1:
            self.isOpen = true
            self.author = nil
            self.assignee = nil
            self.commentator = nil
            self.author = UserToken().name
        case 2:
            self.isOpen = true
            self.author = nil
            self.assignee = nil
            self.commentator = nil
            self.assignee = UserToken().name
        case 3:
            self.isOpen = true
            self.author = nil
            self.assignee = nil
            self.commentator = nil
            self.commentator = UserToken().name
        default:
            self.isOpen = false
        }
    }
}
