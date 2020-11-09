//
//  LabelListWorker.swift
//  IssueTracker
//
//  Created by jaejeon on 2020/11/05.
//

import Foundation

class LabelListWorker {
    func fetchLabels(handler: @escaping (LabelDataSource) -> Void) {
        API.shared.get(from: .labels) { (result: Result<[Label], Error>) in
            switch result {
            case .success(let labels):
                let dataSource = LabelDataSource(with: labels)
                handler(dataSource)
            case .failure:
                break
            }
        }
    }
}
