//
//  FitlterLabelInteractor.swift
//  IssueTracker
//
//  Created by jaejeon on 2020/11/04.
//

import Foundation

protocol FilterLabelListDelegate: class {
    func didSelect(labels: [Label])
}

protocol FilterLabelListBusinessLogic {
    func fetchLabels(with: [Label])
    func select(label: Label)
    func select(labels: [Label])
    func reset()
}

class FilterLabelInteractor: FilterLabelListBusinessLogic {
    enum LabelSection: String {
        case main = "labels"
        case selected = "selected"
    }
    
    weak var viewController: FilterLabelListDisplayLogic?
    weak var delegate: FilterLabelListDelegate?
    var worker = FilterWorker()
    var labels: [Label]?
    var selectedLabels: [Label]?
    
    func fetchLabels(with: [Label]) {
        worker.fetchLables { [weak self](datasource) in
            self?.labels = datasource.labels
            with.forEach({(label) in
                self?.labels?.removeAll(where: {$0.title == label.title})
            })
            self?.viewController?.displayLabelList(with: [.main: self?.labels?.sorted(by: ({ $0.title ?? "" < $1.title ?? "" })) ?? [],
                                                          .selected: with.sorted(by: ({ $0.title ?? "" < $1.title ?? "" }))])
        }
    }
    
    func select(label: Label) {
        delegate?.didSelect(labels: [label])
        self.selectedLabels?.append(label)
    }
    
    func select(labels: [Label]) {
        delegate?.didSelect(labels: labels)
        labels.forEach({self.selectedLabels?.append($0)})
    }
    
    func reset() {
        delegate?.didSelect(labels: [])
        self.selectedLabels = []
    }
}
