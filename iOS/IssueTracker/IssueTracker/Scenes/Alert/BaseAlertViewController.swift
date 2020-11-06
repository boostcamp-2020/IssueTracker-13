//
//  CustomAlerViewController.swift
//  IssueTracker
//
//  Created by 강병민 on 2020/11/05.
//

import UIKit

class BaseAlertViewController: UIViewController {
    
    var mode: AlertMode?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
