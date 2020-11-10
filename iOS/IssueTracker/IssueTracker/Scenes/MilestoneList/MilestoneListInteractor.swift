//
//  MilestoneListInteractor.swift
//  IssueTracker
//
//  Created by jaejeon on 2020/11/06.
//

import Foundation

protocol MilestoneListBusinessLogic {
    func fetchMilestoneList()
    func addMilestone(_ :PostMilestone)
}

class MilestoneListInteractor: MilestoneListBusinessLogic {
    
    weak var viewController: MilestoneListDisplayLogic?
    var milestoneDataSource: MilestoneDataSource?
    let worker = MilestoneListWorker()
    
    func fetchMilestoneList() {
        worker.fetchMilestones { (datasource) in
            self.milestoneDataSource = datasource
            self.viewController?.displayMilestoneList(with: datasource.milestones, at: .main)
        }
    }
    
    func addMilestone(_ postMilestone: PostMilestone) {
        guard let dataSource = milestoneDataSource else { return }
        let newID = dataSource.milestones.count + 1
        let newMilestone = Milestone(postMileStone: postMilestone, id: newID)
        dataSource.add(milestone: newMilestone)
        viewController?.displayMilestoneList(with: dataSource.milestones, at: .main)
    }
    
    func update(milestone: PutMilestone) {
        guard let dataSource = milestoneDataSource else { return }
        dataSource.update(milestone: milestone)
        viewController?.displayMilestoneList(with: dataSource.milestones, at: .main)
    }
    
}

extension MilestoneListInteractor: MilestoneAlertDelegate {
    func didTouchSaveButton(milestone: Milestonable, mode: AlertMode) {
        switch mode {
        case .add:
            guard let milestone = milestone as? PostMilestone else { return }

            API.shared.post(data: milestone, to: .milestones, completion: { (result) in
                switch result {
                case .success:
                    self.addMilestone(milestone)
                case .failure:
                    print("failure")
                }
            })

        case .edit:
            guard let milestone = milestone as? PutMilestone else { return }
            API.shared.put(data: milestone, to: .milestones, completion: { (result) in
                switch result {
                case .success:
                    self.update(milestone: milestone)
                case .failure:
                    print("failure")
                }
            })

        }
    }
    
}
