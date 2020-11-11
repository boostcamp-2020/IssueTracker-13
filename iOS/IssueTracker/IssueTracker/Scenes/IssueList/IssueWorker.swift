//
//  IssueWorker.swift
//  IssueTracker
//
//  Created by jaejeon on 2020/10/29.
//

import Foundation

class IssueWorker {
    
    func fetchIssues(with query: String = "", handler: @escaping (IssueDataSource) -> Void) {
        API.shared.get(with: query, from: .issues) { (result: Result<[Issue], Error>) in
            switch result {
            case .success(let issues):
                let dataSource = IssueDataSource(issues: issues)
                handler(dataSource)
            case .failure:
                break
            }
        }
    }
}
