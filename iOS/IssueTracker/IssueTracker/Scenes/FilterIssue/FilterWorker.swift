//
//  FilterWorker.swift
//  IssueTracker
//
//  Created by 강병민 on 2020/11/03.
//

import Foundation

class FilterWorker {
    
    func fetchAuthors(handler: @escaping ([User]) -> Void) {
        API.shared.get(from: .users) { (result: Result<[User], Error>) in
            switch result {
            case .success(let users):
                handler(users)
            case .failure:
                break
            }
        }
    }
    
    func fetchAssignees(handler: @escaping ([User]) -> Void) {
        API.shared.get(from: .users) { (result: Result<[User], Error>) in
            switch result {
            case .success(let users):
                handler(users)
            case .failure:
                break
            }
        }
    }
    
    func fetchMilestones(handler: @escaping ([Milestone]) -> Void) {
        API.shared.get(from: .milestones) { (result: Result<[Milestone], Error>) in
            switch result {
            case .success(let milestones):
                handler(milestones)
            case .failure:
                break
            }
        }
    }
    
    func fetchLables(handler: @escaping (LabelDataSource) -> Void) {
        API.shared.get(from: .labels) { (result: Result<[Label], Error>) in
            switch result {
            case .success(let labels):
                let dataSource = LabelDataSource(with: labels)
                handler(dataSource)
            case .failure:
                break
            }
        }
    }

}
