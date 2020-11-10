//
//  FilterIssueViewController.swift
//  IssueTracker
//
//  Created by jaejeon on 2020/11/03.
//

import UIKit

protocol FilterIssueDisplayLogic: class {
    func didSelectDetailCondition(at: IndexPath, with: String)
}

class FilterIssueViewController: UITableViewController {
    let interactor = FilterIssueInteractor()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.viewController = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        confignureFilter()
        guard let indexPath = interactor.selectedFilterIndexPath else { return }
        tableView.selectRow(at: indexPath, animated: true, scrollPosition: .bottom)
        tableView(tableView, didSelectRowAt: indexPath)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let segueId = segue.identifier else { return }
        switch segueId {
        case "showAuthorList":
            guard let userListVC = segue.destination as? FilterUserListViewController else { return }
            userListVC.interactor.userMode = .author
            userListVC.interactor.delegate = interactor
        case "showAssigneeList":
            guard let userListVC = segue.destination as? FilterUserListViewController else { return }
            userListVC.interactor.userMode = .assignee
            userListVC.interactor.delegate = interactor
        case "showFilterMilestoneList":
            guard let filterMilestoneVC = segue.destination as? FilterMilestoneListViewController else { return }
            filterMilestoneVC.interactor.delegate = interactor
        case "showFilterLabelList":
            guard let vc = segue.destination as? FilterLabelListViewController else { return }
            vc.interactor.delegate = interactor
        default:
            break
        }

    }

    func confignureFilter() {
        guard let filter = interactor.filter else { return }
        if filter.isOpen {
            tableView.selectRow(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: .bottom)
            tableView(tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
        } else {
            tableView.selectRow(at: IndexPath(row: 4, section: 0), animated: true, scrollPosition: .bottom)
            tableView(tableView, didSelectRowAt: IndexPath(row: 4, section: 0))
        }
        didSelectDetailCondition(at: IndexPath(row: 0, section: 1), with: filter.author?.userName ?? "")
        didSelectDetailCondition(at: IndexPath(row: 1, section: 1), with: filter.label?.title ?? "")
        didSelectDetailCondition(at: IndexPath(row: 2, section: 1), with: filter.milestone ?? "")
        didSelectDetailCondition(at: IndexPath(row: 3, section: 1), with: filter.assignee?.userName ?? "")
    }
    
    @IBAction func didTouchBarButton(_ sender: UIBarButtonItem) {
        if sender.title == "Done" {
            interactor.sendQuery()
        }
        dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.selectionStyle = .none
        if indexPath.section == 1 {
            return
        }
        if indexPath.row == 0 {
            interactor.filter?.isOpen = true
        } else if indexPath.row == 2 {
//                interactor.filter?.author = ""
        } else if indexPath.row == 4 {
            interactor.filter?.isOpen = false
        }
        interactor.selectedFilterIndexPath = indexPath
        cell?.accessoryType = .checkmark
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            return
        }
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .none
    }
}

extension FilterIssueViewController: FilterIssueDisplayLogic {
    func didSelectDetailCondition(at indexPath: IndexPath, with value: String) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.detailTextLabel?.text = value
    }
}
