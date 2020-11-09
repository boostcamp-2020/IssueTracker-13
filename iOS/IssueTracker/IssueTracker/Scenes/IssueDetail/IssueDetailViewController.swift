//
//  IssueDetailViewController.swift
//  IssueTracker
//
//  Created by jaejeon on 2020/11/09.
//

import UIKit

class IssueDetailViewController: UIViewController {
    var issue: Issue?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if segue.identifier == "ShowIssueEditViewController" {
            let navigationViewController = segue.destination as? UINavigationController
            let viewController = navigationViewController?.viewControllers.first as? IssueEditViewController
            viewController?.issue = issue
        }
    }
    
    @IBAction func didTouchEditButton(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "ShowIssueEditViewController", sender: issue)
    }
    
}
