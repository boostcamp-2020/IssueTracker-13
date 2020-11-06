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
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
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

    @IBAction func didTouchBarButton(_ sender: UIBarButtonItem) {
        if sender.title == "Done" {
            
        }
        dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            return
        }
        interactor.selectedFilterIndexPath = indexPath
        let cell = tableView.cellForRow(at: indexPath)
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
