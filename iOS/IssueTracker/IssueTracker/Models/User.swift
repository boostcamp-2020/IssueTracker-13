//
//  Assignee.swift
//  IssueTracker
//
//  Created by jaejeon on 2020/10/29.
//

import Foundation

struct User: Codable, Hashable {
    let userName: String
    let profile: String?
    
    enum CodingKeys : String, CodingKey{
        case userName, profile
    }}
