//
//  LabelDataSource.swift
//  IssueTracker
//
//  Created by jaejeon on 2020/11/05.
//

import Foundation

class LabelDataSource {
    enum Section {
        case main
    }
    
    private(set) var labels: [Label]

    init(with labels: [Label]) {
        self.labels = labels
    }
}
