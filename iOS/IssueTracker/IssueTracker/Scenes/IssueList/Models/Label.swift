//
//  Label.swift
//  IssueTracker
//
//  Created by jaejeon on 2020/10/29.
//

import Foundation

struct Label: Codable, Hashable {
    let id: Int
    let title: String?
    let description: String?
    let color: String?
    let backgroundColor: String?
}
