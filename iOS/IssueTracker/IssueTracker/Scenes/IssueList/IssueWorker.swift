//
//  IssueWorker.swift
//  IssueTracker
//
//  Created by jaejeon on 2020/10/29.
//

import Foundation

class IssueWorker {
    
    func fetchIssues(handler: @escaping (IssueDataSource) -> Void) {
        let issues = [Issue(id: 0,
                            title: "이슈 0",
                            preview: "이슈 0 프리뷰 입니다.",
                            milestone: "마일스톤 1",
                            labels: [Label(id: 1, title: "라벨입니다", description: "이것은 라벨입니다", color: "", backgroundColor: "")],
                            author: "작성자",
                            assignees: [],
                            isOpen: true,
                            createAt: "2019-10-27 19:11:24"),
                      Issue(id: 1,
                            title: "이슈 1",
                            preview: "이슈 1 프리뷰 입니다.",
                            milestone: "마일스톤 0",
                            labels: [],
                            author: "작성자",
                            assignees: [],
                            isOpen: true,
                            createAt: "2019-10-27 19:11:24"),
                    Issue(id: 2,
                          title: "이슈 2",
                          preview: "이슈 2 프리뷰 입니다.",
                          milestone: "마일스톤 0",
                          labels: [],
                          author: "작성자",
                          assignees: [],
                          isOpen: true,
                          createAt: "2019-10-27 19:11:24")]
        let dataSource = IssueDataSource(issues: issues)
        handler(dataSource)
    }
}
