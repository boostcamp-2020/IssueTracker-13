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
            self.issueDataSource = datasource
            self.viewController?.displayLabelList(with: datasource.labels, at: .main)
        }
    }
    
    func add(label: PostLabel) {
        guard let dataSource = issueDataSource else { return }
        let newID = dataSource.labels.count + 1
        let newLabel = Label(postLabel: label, id: newID)
        dataSource.add(label: newLabel)
        viewController?.displayLabelList(with: dataSource.labels, at: .main)
    }
    
    func update(label: Label) {
        guard let dataSource = issueDataSource else { return }
        dataSource.update(label: label)
        viewController?.displayLabelList(with: dataSource.labels, at: .main)
    }
    
}

extension LabelListInteractor: LabelAlertDelegate {
    
    func didTouchSaveButton(label: Labelable, mode: AlertMode) {
        switch mode {
        case .add:
            guard let label = label as? PostLabel else { return }

            API.shared.post(data: label, to: .labels, completion: { (result) in
                switch result {
                case .success:
                    self.add(label: label)
                case .failure:
                    print("failure")
                }
            })

        case .edit:
            guard let label = label as? Label else { return }
            API.shared.put(data: label, to: .labels, completion: { (result) in
                switch result {
                case .success:
                    self.update(label: label)
                case .failure:
                    print("failure")
                }
            })
        }
    }
    
}
