//
//  MilestoneAlerViewController.swift
//  IssueTracker
//
//  Created by 강병민 on 2020/11/05.
//

import UIKit

protocol MilestoneAlertDelegate: class {
    func didTouchSaveButton(milestone: Milestonable, mode: AlertMode)
}

class MilestoneAlertViewController: BaseAlertViewController {
    
    var id: Int?
    @IBOutlet weak var alertView: CustomAlertView!
    @IBOutlet var dateView: UIView!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    weak var delegate: MilestoneAlertDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.backgroundColor = .none
        datePicker.tintColor = .black
        addInputAccessoryForTextFields(textFields: [alertView.titleTextField, alertView.descriptionTextField], previousNextable: true)
        alertView.stackView.addArrangedSubview(dateView)
        alertView.closeButton.addTarget(self, action: #selector(didTouchCloseButton), for: .touchUpInside)
        alertView.resetButton.addTarget(self, action: #selector(didTouchResetButton), for: .touchUpInside)
        alertView.saveButton.addTarget(self, action: #selector(didTouchSaveButton), for: .touchUpInside)
    }

    func configure(_ mode: AlertMode, milestone: Milestone?) {
        self.mode = mode
        switch mode {
        case .edit:
            id = milestone?.id
            alertView.titleTextField.text = milestone?.title
            alertView.descriptionTextField.text = milestone?.description
            guard let date = milestone?.dueDate.toDate() else { return }
            datePicker.setDate(date, animated: true)
        default:
            break
        }
    }
    
    @objc func didTouchCloseButton() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func didTouchResetButton() {
        alertView.titleTextField.text = ""
        alertView.descriptionTextField.text = ""
        datePicker.setDate(Date(), animated: true)
    }
    
    @objc func didTouchSaveButton() {
        guard let mode = mode else { return }
        let milestone: Milestonable
        let title = alertView.titleTextField.text
        let description = alertView.descriptionTextField.text
        let dateString = datePicker.date.toServerString()

        switch mode {
        case .add:
            print("TODO")
//            milestone = PostMilestone(title: <#T##String#>, description: <#T##String#>, dueDate: <#T##String#>, isDeleted: <#T##Bool#>)
        case .edit:
            print("TODO")
//            milestone = PutMilestone(id: <#T##Int#>, title: <#T##String?#>, description: <#T##String?#>, dueDate: <#T##String?#>, isDeleted: <#T##Bool#>)
        default:
            break
        }
        milestone = PutMilestone(id: 1, title: "", description: "", dueDate: "", isDeleted: false) // build에러 방지용 (나중에 지워야함)
        delegate?.didTouchSaveButton(milestone: milestone, mode: mode)
    }
}
