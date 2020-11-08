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

}
