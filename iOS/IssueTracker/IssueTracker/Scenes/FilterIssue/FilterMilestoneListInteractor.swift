//
//  FilterMilestoneListInteractor.swift
//  IssueTracker
//
//  Created by 강병민 on 2020/11/04.
//

import Foundation

protocol FilterMilestoneListDelegate: class {
    func didSelect(milestone: Milestone?)
}

protocol FilterMilestoneListBusinessLogic {
    func fetchMilestones(with: Milestone?)
    func select(milestone: Milestone)
    func deselect()
}

class FilterMilestoneListInteractor {

    enum MilestoneSection: String {
        case selected = "selected"
        case main = "milestones"
    }

    weak var delegate: FilterMilestoneListDelegate?
    weak var viewController: FilterMilestoneDisplayLogic?
    
    var milestones: [Milestone]?
    var selectedMilestone: Milestone?
    var worker = FilterWorker()
    
}

extension FilterMilestoneListInteractor: FilterMilestoneListBusinessLogic {

    func fetchMilestones(with: Milestone?) {
        worker.fetchMilestones { [weak self] (milestones) in
            self?.milestones = milestones
            self?.milestones?.removeAll(where: { $0.id == with?.id})
            if let milestone = self?.selectedMilestone {
                self?.viewController?.displayMilestoneList(with: [.selected: [milestone], .main: self?.milestones ?? []])
            } else {
                self?.viewController?.displayMilestoneList(with: [.selected: [], .main: self?.milestones ?? []])
            }
            
        }
    }
    
    func select(milestone: Milestone) {
        delegate?.didSelect(milestone: milestone)
        selectedMilestone = milestone
    }
    
    func deselect() {
        delegate?.didSelect(milestone: nil)
    }
    
}
