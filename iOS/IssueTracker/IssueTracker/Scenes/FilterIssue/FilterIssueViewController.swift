//
//  FilterIssueViewController.swift
//  IssueTracker
//
//  Created by jaejeon on 2020/11/03.
//

import UIKit

class FilterIssueViewController: UITableViewController {

    let interactor = FilterIssueInteractor()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let segueId = segue.identifier else { return }
        switch segueId {
        case "showAuthorList":
            guard let userListVC = segue.destination as? UserListViewController else { return }
            userListVC.interactor.userMode = .author
            userListVC.interactor.delegate = interactor
        case "showAssigneeList":
            guard let userListVC = segue.destination as? UserListViewController else { return }
            userListVC.interactor.userMode = .assignee
            userListVC.interactor.delegate = interactor
        case "showFilterMilestoneList":
            guard let filterMilestoneVC = segue.destination as? FilterMilestoneListViewController else { return }
            filterMilestoneVC.interactor.delegate = interactor
        default:
            break
        }

    }
    
    @IBAction func didTouchBarButton(_ sender: UIBarButtonItem) {
        if sender.title == "Done" {
            
        }
        dismiss(animated: true, completion: nil)
    }
}
