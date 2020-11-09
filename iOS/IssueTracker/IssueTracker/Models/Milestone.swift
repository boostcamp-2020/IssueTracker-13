//
//  Milestone.swift
//  IssueTracker
//
//  Created by 강병민 on 2020/11/05.
//

import Foundation

protocol Milestonable {
}

struct Milestone: Codable, Hashable {
    let id: Int
    let title, description, dueDate: String
    let allIssueCount, closedIssueCount: Int
    
    init (postMileStone: PostMilestone, id: Int) {
        self.id = id
        self.title = postMileStone.title
        self.description = postMileStone.description
        self.dueDate = postMileStone.dueDate
        self.allIssueCount = 0
        self.closedIssueCount = 0
    }
    
    init (putMilestone: PutMilestone, milestone: Milestone) {
        self.id = putMilestone.id
        self.title = putMilestone.title
        self.description = putMilestone.description
        self.dueDate = putMilestone.dueDate
        self.allIssueCount = milestone.allIssueCount
        self.closedIssueCount = milestone.closedIssueCount
    }

}

struct PostMilestone: Codable, Milestonable {
    let title, description, dueDate: String
    let isDeleted: Bool
}

struct PutMilestone: Codable, Milestonable {
    let id: Int
    let title, description, dueDate: String
    let isDeleted: Bool
}
