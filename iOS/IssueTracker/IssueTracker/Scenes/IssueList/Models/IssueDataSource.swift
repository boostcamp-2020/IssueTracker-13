//
//  IssueDataSource.swift
//  IssueTracker
//
//  Created by 강병민 on 2020/10/28.
//

import Foundation

protocol IssueDataSourceProtocol {
    func add(issue: Issue)
    func remove(issue: Issue)
    func remove(issues: [Issue])
    func close(issue: Issue)
    func close(issues: [Issue])
}

class IssueDataSource {
    
    enum Section {
        case main
    }
    
    private(set) var issues: [Issue]
        
    init(issues: [Issue]) {
        self.issues = issues
    }
}

extension IssueDataSource: IssueDataSourceProtocol {
    
    func add(issue: Issue) {
        issues.append(issue)
    }

    func remove(issue: Issue) {
        
    }

    func remove(issues: [Issue]) {

    }

    func close(issue: Issue) {

    }

    func close(issues: [Issue]) {

    }

}
