//
//  Milestone.swift
//  IssueTracker
//
//  Created by 강병민 on 2020/11/05.
//

import Foundation

struct Milestone: Codable, Hashable {
    let id: Int
    let title, description, dueDate: String
    let isDeleted: Bool
    let createdAt, updatedAt: String
}

struct PostMilestone: Codable {
    let title, description, dueDate: String
    let isDeleted: Bool
}

struct PutMilestone: Codable {
    let id: Int
    let title, description, dueDate: String?
    let isDeleted: Bool
}
