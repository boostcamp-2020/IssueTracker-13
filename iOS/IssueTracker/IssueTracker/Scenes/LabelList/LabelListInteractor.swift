//
//  LabelListInteractor.swift
//  IssueTracker
//
//  Created by jaejeon on 2020/11/05.
//

import Foundation

protocol LabelListBusinessLogic {
    func fetchLabelList()
}

class LabelListInteractor: LabelListBusinessLogic {
    weak var viewController: LabelListDisplayLogic?
    var issueDataSource: LabelDataSource?
    let worker = LabelListWorker()
    
    func fetchLabelList() {
        worker.fetchLabels { (datasource) in
            self.viewController?.displayLabelList(with: datasource.labels, at: .main)
        }
    }
    
}
