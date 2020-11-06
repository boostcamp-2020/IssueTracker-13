//
//  Milestone.swift
//  IssueTracker
//
//  Created by 강병민 on 2020/11/05.
//

import Foundation
protocol Milestonable {
}
struct Milestone: Codable {
    let id: Int
    let title, description, dueDate: String
    let isDeleted: Bool
    let createdAt, updatedAt: String
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
