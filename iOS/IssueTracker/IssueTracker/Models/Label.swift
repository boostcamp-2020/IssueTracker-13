//
//  Label.swift
//  IssueTracker
//
//  Created by jaejeon on 2020/10/29.
//

import Foundation

protocol Labelable {
}

struct Label: Codable, Hashable, Labelable {
    let id: Int?
    let title: String?
    let description: String?
    let color: String?
    let backgroundColor: String?
}

extension Label {
    init (postLabel: PostLabel, id: Int) {
        self.id = id
        self.title = postLabel.title
        self.description = postLabel.description
        self.color = postLabel.color
        self.backgroundColor = postLabel.backgroundColor
    }
}

struct PostLabel: Codable, Labelable {
    let title: String
    let description: String
    let color: String
    let backgroundColor: String
}
