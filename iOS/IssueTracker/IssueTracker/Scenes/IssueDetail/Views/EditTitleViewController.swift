//
//  ViewController.swift
//  IssueTracker
//
//  Created by 강병민 on 2020/11/12.
//

import UIKit

class EditTitleViewController: UIAlertController {
    
    var didTouchOKButton: ((String) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func configure(with text: String) {
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        let okAction = UIAlertAction(title: "보내기", style: .default) { (_: UIAlertAction) -> Void in
            guard let message = self.textFields?[0].text else { return }
            self.didTouchOKButton?(message)
        }

        self.addAction(cancelAction)
        self.addAction(okAction)
        self.addTextField { textField in
            let heightConstraint = NSLayoutConstraint(item: textField,
                                                      attribute: .height,
                                                      relatedBy: .equal,
                                                      toItem: nil,
                                                      attribute: .notAnAttribute,
                                                      multiplier: 1,
                                                      constant: 50)
            textField.addConstraint(heightConstraint)
            textField.text = text
        }
    }

}
