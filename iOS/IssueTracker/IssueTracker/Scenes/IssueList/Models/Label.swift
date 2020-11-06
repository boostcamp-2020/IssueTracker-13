//
//  Label.swift
//  IssueTracker
//
//  Created by jaejeon on 2020/10/29.
//

import Foundation

protocol Labelable {
}

struct Label: Codable, Hashable {
    let id: Int
    let title: String?
    let description: String?
    let color: String?
    let backgroundColor: String?
}

struct PostLabel: Codable, Labelable {
    let title: String?
    let description: String?
    let color: String?
    let backgroundColor: String?
}

struct PutLabel: Codable, Labelable {
    let id: Int
    let title: String?
    let description: String?
    let color: String?
    let backgroundColor: String?
}
