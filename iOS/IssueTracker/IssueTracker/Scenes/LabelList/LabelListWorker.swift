//
//  LabelListWorker.swift
//  IssueTracker
//
//  Created by jaejeon on 2020/11/05.
//

import Foundation

class LabelListWorker {
    func fetchLabels(handler: @escaping (LabelDataSource) -> Void) {
        let labels = [Label(id: 0, title: "레이블0", description: "레이블 설명입니다.", color: "", backgroundColor: ""), Label(id: 1, title: "레이블0", description: "레이블 설명입니다.", color: "", backgroundColor: "")]
        let dataSource = LabelDataSource(with: labels)
        handler(dataSource)
    }
}
