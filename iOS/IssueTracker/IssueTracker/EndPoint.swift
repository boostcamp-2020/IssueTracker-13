//
//  EndPoint.swift
//  IssueTracker
//
//  Created by jaejeon on 2020/11/09.
//

import Foundation

enum EndPoint: String {
    case labels
    case issues
    case comments
    case milestones
    case users
    
    var baseURL: String {
        "http://27.96.130.188:3000/api/"
    }
    
    var path: String {
        baseURL + self.rawValue
    }
}
