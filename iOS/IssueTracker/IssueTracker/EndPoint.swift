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
    case signIn = "auth/signIn"
    
    var baseURL: String {
        "http://27.96.130.188:3000/api/" //배포용 : http://101.101.210.228
    }
    
    var path: String {
        baseURL + self.rawValue
    }
}
