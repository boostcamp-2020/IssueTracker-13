//
//  MilestoneListWorker.swift
//  IssueTracker
//
//  Created by jaejeon on 2020/11/06.
//

import Foundation

class MilestoneListWorker {
    func fetchMilestones(handler: @escaping (MilestoneDataSource) -> Void) {
        API.shared.getMilestones { (result) in
            switch result{
            case .success(let milestones):
                let dataSource = MilestoneDataSource(with: milestones)
                handler(dataSource)
            case .failure:
                break
            }
        }
    }
    
}
