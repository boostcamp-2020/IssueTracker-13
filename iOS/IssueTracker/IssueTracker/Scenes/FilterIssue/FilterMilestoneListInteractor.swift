//
//  FilterMilestoneListInteractor.swift
//  IssueTracker
//
//  Created by 강병민 on 2020/11/04.
//

import Foundation

protocol FilterMilestoneListDelegate: class {
    func didSelect(milestone: Milestone)
}

protocol FilterMilestoneListBusinessLogic {
    func fetchMilestones()
    func select(milestone: Milestone)
}

class FilterMilestoneListInteractor {

    enum MilestoneSection {
        case main
    }

    weak var delegate: FilterMilestoneListDelegate?
    weak var viewController: FilterMilestoneDisplayLogic?
    
    var milestones: [Milestone]?
    var worker = FilterWorker()
    
}

extension FilterMilestoneListInteractor: FilterMilestoneListBusinessLogic {
    
    func fetchMilestones() {
        worker.fetchMilestones { [weak self] (milestones) in
            self?.milestones = milestones
            self?.viewController?.displayMilestoneList(with: milestones, at: .main)
        }
    }
    
    func select(milestone: Milestone) {
        delegate?.didSelect(milestone: milestone)
    }

}
