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
    
    func add(label: Label) {
        labels.append(label)
    }
    
    func update(label: Label) {
        guard let index = labels.firstIndex(where: {$0.id == label.id}) else { return }
        let newLabel = label
        labels[index] = newLabel
    }
    
}
