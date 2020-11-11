//
//  IssueDetailViewController.swift
//  IssueTracker
//
//  Created by jaejeon on 2020/11/09.
//

import UIKit
import FloatingPanel

class IssueDetailViewController: UIViewController {
    var issue: Issue?
    var bottomSheet: FloatingPanelController {
        return FloatingPanelController()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true
        configureBottomSheet()
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

extension IssueDetailViewController: FloatingPanelControllerDelegate {
    func configureBottomSheet() {
        bottomSheet.delegate = self // Optional

        // Set a content view controller.
        let contentVC = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "IssueBottomSheetViewController") as? IssueBottomSheetViewController
        bottomSheet.set(contentViewController: contentVC)

        // Track a scroll view(or the siblings) in the content view controller.
//        bottomSheet.track(scrollView: contentVC.tableView)

        // Add and show the views managed by the `FloatingPanelController` object to self.view.
        bottomSheet.addPanel(toParent: self)
    }
}
