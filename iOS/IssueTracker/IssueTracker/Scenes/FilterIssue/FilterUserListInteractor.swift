//
//  UserListInteractor.swift
//  IssueTracker
//
//  Created by 강병민 on 2020/11/03.
//

import Foundation

protocol FilterUserListDelegate: class {
    func didSelect(user: User, mode: FilterUserListInteractor.UserMode)
}

protocol FilterUserListBusinessLogic {
    func fetchUsers()
    func select(user: User)
}

class FilterUserListInteractor {

    enum UserSection {
        case main, suggest
    }
    enum UserMode {
        case author, assignee
    }
    
    weak var delegate: FilterUserListDelegate?
    weak var viewController: FilterUserListDisplayLogic?
    
    var userMode: UserMode?
    var users: [User]?
    var worker = FilterWorker()
    
}

extension FilterUserListInteractor: FilterUserListBusinessLogic {
    
    func fetchUsers() {
        switch userMode {
        case .author:
            worker.fetchAuthors { [weak self] (users) in
                self?.users = users
            }
        case .assignee:
            worker.fetchAssignees { [weak self] (users) in
                self?.users = users
            }
        case .none:
            break
        }
        viewController?.displayUserList(with: self.users ?? [], at: .main)
    }
    
    func select(user: User) {
        guard let userMode = userMode else { return }
        delegate?.didSelect(user: user, mode: userMode)
    }

}
