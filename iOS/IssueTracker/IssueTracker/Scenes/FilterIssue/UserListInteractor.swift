//
//  UserListInteractor.swift
//  IssueTracker
//
//  Created by 강병민 on 2020/11/03.
//

import Foundation

protocol UserListDelegate: class {
    func didSelect(user: User)
}

protocol UserListBusinessLogic {
    func fetchUsers()
    func select(user: User)
}

class UserListInteractor {

    enum UserSection {
        case main, suggest
    }
    enum UserMode {
        case author, assignee
    }
    
    weak var delegate: UserListDelegate?
    weak var viewController: UserListDisplayLogic?
    
    var userMode: UserMode?
    var users: [User]?
    var worker = FilterWorker()
    
}

extension UserListInteractor: UserListBusinessLogic {
    
    func fetchUsers() {
        switch userMode {
        case .author:
            worker.fetchAuthors { [weak self] (users) in
                self?.users = users
            }
        case .assignee:
            worker.fetchAuthors { [weak self] (users) in
                self?.users = users
            }
        case .none:
            break
        }
        viewController?.displayUserList(with: self.users ?? [], at: .main)
    }
    
    func select(user: User) {
        delegate?.didSelect(user: user)
    }

}
