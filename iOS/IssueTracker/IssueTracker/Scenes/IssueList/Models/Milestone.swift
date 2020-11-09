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
    let isDeleted: Bool
    let createdAt, updatedAt: String
    
    init (postMileStone: PostMilestone, id: Int){
        self.id = id
        self.title = postMileStone.title
        self.description = postMileStone.description
        self.dueDate = postMileStone.dueDate
        self.isDeleted = false
        self.createdAt = Date().toServerString()
        self.updatedAt = Date().toServerString()
    }
    
}

struct PostMilestone: Codable, Milestonable {
    let title, description, dueDate: String
    let isDeleted: Bool
}

struct PutMilestone: Codable, Milestonable {
    let id: Int
    let title, description, dueDate: String?
    let isDeleted: Bool
}
