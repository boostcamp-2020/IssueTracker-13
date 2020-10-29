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
    
}

extension IssueDataSource: IssueDataSourceProtocol {

    func add(issue: Issue) {
        
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
