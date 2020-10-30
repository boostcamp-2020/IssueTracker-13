//
//  Label.swift
//  IssueTracker
//
//  Created by jaejeon on 2020/10/29.
//

import Foundation

struct Label: Codable {
    let title: String
    let color: String
    let backgroundColor: String
}

enum CodingKeys: String, CodingKey {
    case backgroundColor = "background-color"
}
