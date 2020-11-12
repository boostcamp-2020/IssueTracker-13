//
//  IssueDetailDataSource.swift
//  IssueTracker
//
//  Created by 강병민 on 2020/11/11.
//

import Foundation

class IssueDetailDataSource {
    
    enum Section {
        case main
    }
    
    private(set) var comments: [Comment]
    
    init(comments: [Comment]) {
        self.comments = comments
    }
    
}
