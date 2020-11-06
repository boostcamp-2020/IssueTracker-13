//
//  MilestoneListWorker.swift
//  IssueTracker
//
//  Created by jaejeon on 2020/11/06.
//

import Foundation

class MilestoneListWorker {
    func fetchMilestones(handler: @escaping (MilestoneDataSource) -> Void) {
        let milestones = [Milestone(id: 0, title: "마일스톤 0", description: "마일스톤 입니당", dueDate: "DATE", isDeleted: true, createdAt: "", updatedAt: "")]
        let dataSource = MilestoneDataSource(with: milestones)
        handler(dataSource)
    }}
