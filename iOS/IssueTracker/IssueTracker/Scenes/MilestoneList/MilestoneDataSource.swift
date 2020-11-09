//
//  MilestoneDataSource.swift
//  IssueTracker
//
//  Created by jaejeon on 2020/11/06.
//

import Foundation

class MilestoneDataSource {
    enum Section {
        case main
    }
    
    private(set) var milestones: [Milestone]

    init(with milestones: [Milestone]) {
        self.milestones = milestones
    }
    
    func add(milestone: Milestone) {
        milestones.append(milestone)
    }
    
    func update(milestone: PutMilestone) {
        guard let index = milestones.firstIndex(where: {$0.id == milestone.id}) else { return }
        let newMilestone = Milestone(putMilestone: milestone, milestone: milestones[index])
        milestones[index] = newMilestone
    }

}
