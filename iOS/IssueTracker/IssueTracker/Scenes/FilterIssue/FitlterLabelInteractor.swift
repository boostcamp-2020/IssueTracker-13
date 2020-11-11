//
//  FitlterLabelInteractor.swift
//  IssueTracker
//
//  Created by jaejeon on 2020/11/04.
//

import Foundation

protocol FilterLabelListDelegate: class {
    func didSelect(label: Label)
}

protocol FilterLabelListBusinessLogic {
    func fetchLabels()
    func select(label: Label)
}

class FilterLabelInteractor: FilterLabelListBusinessLogic {
    enum LabelSection {
        case main
    }
    
    weak var viewController: FilterLabelListDisplayLogic?
    weak var delegate: FilterLabelListDelegate?
    var worker = FilterWorker()
    var labels: [Label]?
    
    func fetchLabels() {
        worker.fetchLables { [weak self](datasource) in
            self?.labels = datasource.labels
            self?.viewController?.displayLabelList(with: self?.labels ?? [], at: .main)
        }
    }
    
    func select(label: Label) {
        delegate?.didSelect(label: label)
    }
}
