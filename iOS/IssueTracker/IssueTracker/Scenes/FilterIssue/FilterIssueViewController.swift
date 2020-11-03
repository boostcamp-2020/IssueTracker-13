//
//  FilterIssueViewController.swift
//  IssueTracker
//
//  Created by jaejeon on 2020/11/03.
//

import UIKit

class FilterIssueViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func didTouchBarButton(_ sender: UIBarButtonItem) {
        if sender.title == "Done" {
            
        }
        dismiss(animated: true, completion: nil)
    }
}
