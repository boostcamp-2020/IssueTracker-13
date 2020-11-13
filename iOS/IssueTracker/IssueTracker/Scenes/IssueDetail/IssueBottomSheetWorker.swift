//
//  IssueBottomSheetWorker.swift
//  IssueTracker
//
//  Created by jaejeon on 2020/11/12.
//

import Foundation

class IssueEditWorker {
    func update(issue: Issue) {
        let data: [String: Any] = ["id": issue.id,
                    "title": issue.title,
                    "isOpen": issue.isOpen,
                    "Milestone": ["id": issue.milestone.id] ,
                    "Assignee": [["id": 1]], // 수정 해야함
                    "Labels": issue.labels.map({ ["id": $0.id] })]

        API.shared.put(at: "\(issue.id)", data: data, to: .issues) { (result: Result<String, Error>) in
            switch result {
            case .success(let string):
                print(string)
            case .failure:
                break
            }
        }
    }
}
