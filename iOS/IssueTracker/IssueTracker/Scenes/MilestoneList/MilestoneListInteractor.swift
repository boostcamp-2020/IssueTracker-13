//
//  MilestoneListInteractor.swift
//  IssueTracker
//
//  Created by jaejeon on 2020/11/06.
//

import Foundation

protocol MilestoneListBusinessLogic {
    func fetchMilestoneList()
}

class MilestoneListInteractor: MilestoneListBusinessLogic {
    weak var viewController: MilestoneListDisplayLogic?
    let worker = MilestoneListWorker()
    
    func fetchMilestoneList() {
        worker.fetchMilestones { (datasource) in
            self.viewController?.displayMilestoneList(with: datasource.milestones, at: .main)
        }
    }
}
