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
    var openedIssues: [Issue] {
        issues.filter({ $0.isOpen })
    }
    
    init(issues: [Issue]) {
        self.issues = issues
    }
}

extension IssueDataSource: IssueDataSourceProtocol {
    
    func add(issue: Issue) {
        issues.append(issue)
    }

    func remove(issue: Issue) {
        issues.removeAll { (item) -> Bool in
            item == issue
        }
    }

    func remove(issues items: [Issue]) {
        items.forEach({ remove(issue: $0) })
    }

    func close(issue: Issue) {
        var item = issue
        item.isOpen = false
        guard let index = issues.firstIndex(where: {$0 == issue}) else { return }
        issues[index] = item
    }

    func close(issues: [Issue]) {

    }

}
