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
        addInputAccessoryForTextFields(textFields: [alertView.titleTextField,
                                                    alertView.descriptionTextField],
                                       previousNextable: true)
        alertView.stackView.addArrangedSubview(dateView)
        configureTargets()
        configure(datePicker: datePicker)
    }
    
    func configureTargets() {
        alertView.titleTextField.addTarget(self, action: #selector(didTitleTextFieldChange), for: .editingChanged)
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
            guard let date = milestone?.dueDate?.toDate() else { return }
            datePicker.setDate(date, animated: true)
        case .add:
            alertView.saveButton.isEnabled = false
        }
    }
    
    func configure(datePicker :UIDatePicker){
        datePicker.backgroundColor = .none
        datePicker.tintColor = .black
    }
    
    @objc func didTitleTextFieldChange(_ textField: UITextField) {
        guard let titleText = textField.text else { return }
        alertView.saveButton.isEnabled = !titleText.isEmpty
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
        guard let title = alertView.titleTextField.text else { return }
        guard let description = alertView.descriptionTextField.text else { return }
        let dateString = datePicker.date.toServerString()

        switch mode {
        case .add:
            milestone = PostMilestone(title: title, description: description, dueDate: dateString, isDeleted: false)
        case .edit:
            guard let id = id else { return }
            milestone = PutMilestone(id: id,
                                     title: title, description: description, dueDate: dateString, isDeleted: false)
        }
        delegate?.didTouchSaveButton(milestone: milestone, mode: mode)
        dismiss(animated: true, completion: nil)
    }
}
