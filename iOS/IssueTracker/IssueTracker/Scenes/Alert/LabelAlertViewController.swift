//
//  LabelAlertViewController.swift
//  IssueTracker
//
//  Created by 강병민 on 2020/11/05.
//

import UIKit
protocol LabelAlertDelegate: class {
    func didTouchSaveButton(label: Labelable, mode: AlertMode)
}
class LabelAlertViewController: BaseAlertViewController {

    var id: Int?
    @IBOutlet weak var alertView: CustomAlertView!
    @IBOutlet var colorView: UIView!
    @IBOutlet weak var colorTextField: UITextField!
    
    weak var delegate: LabelAlertDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        alertView.stackView.addArrangedSubview(colorView)
        alertView.closeButton.addTarget(self, action: #selector(didTouchCloseButton), for: .touchUpInside)
        alertView.resetButton.addTarget(self, action: #selector(didTouchResetButton), for: .touchUpInside)
        alertView.saveButton.addTarget(self, action: #selector(didTouchSaveButton), for: .touchUpInside)
    }

    func configure(_ mode: AlertMode, label: Label?) {
        switch mode {
        case .edit:
            self.id = label?.id
            alertView.titleTextField.text = label?.title
            alertView.descriptionTextField.text = label?.description
            colorTextField.text = label?.color
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
        colorTextField.text = ""
    }
    
    @objc func didTouchSaveButton() {
        guard let mode = mode else { return }
        let label: Labelable
        switch mode {
        case .add:
            let backgroundColor = ""
            let color = calculateColor(with: backgroundColor)
            label = PostLabel(title: alertView.titleTextField.text, description: alertView.descriptionTextField.text, color: color, backgroundColor: backgroundColor)
        case .edit:
            let backgroundColor = ""
            let color = calculateColor(with: backgroundColor)
            label = PutLabel(id: 1, title: alertView.titleTextField.text, description: alertView.descriptionTextField.text, color: color, backgroundColor: backgroundColor)
        default:
            break
        }
        delegate?.didTouchSaveButton(label: label, mode: mode)
    }
    
    func calculateColor(with backgroundColor: String) -> String {
        return ""
    }
}
