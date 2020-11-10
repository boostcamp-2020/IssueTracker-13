//
//  LabelAlertViewController.swift
//  IssueTracker
//
//  Created by 강병민 on 2020/11/05.
//

import UIKit

protocol LabelAlertDisplayLogic: class {
    func displaySaveButton(as isEnabled: Bool)
    func displayColorTextField(with hexString: String)
    func displayColorPickerView(with color: UIColor)
}

class LabelAlertViewController: BaseAlertViewController {

    @IBOutlet weak var alertView: CustomAlertView!
    @IBOutlet var colorView: UIView!
    @IBOutlet weak var colorTextField: UITextField!
    @IBOutlet weak var colorPickerView: UIView!
    
    let interactor = LabelAlertInteractor()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.viewController = self
        addInputAccessoryForTextFields(textFields: [alertView.titleTextField,
                                                    alertView.descriptionTextField,
                                                    colorTextField],
                                       previousNextable: true)
        alertView.stackView.addArrangedSubview(colorView)
        alertView.closeButton.addTarget(self, action: #selector(didTouchCloseButton), for: .touchUpInside)
        alertView.resetButton.addTarget(self, action: #selector(didTouchResetButton), for: .touchUpInside)
        alertView.saveButton.addTarget(self, action: #selector(didTouchSaveButton), for: .touchUpInside)
        colorTextField.addTarget(self, action: #selector(didTextFieldChange(_:)), for: .editingChanged)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
         let touch = touches.first
         if touch?.view != alertView {
            dismiss(animated: true, completion: nil)
        }
    }
    
    func configure(_ mode: AlertMode, label: Label?) {
        interactor.mode = mode
        switch mode {
        case .edit:
            interactor.id = label?.id
            alertView.titleTextField.text = label?.title
            alertView.descriptionTextField.text = label?.description
            
            guard let backgroundColorString = label?.backgroundColor else { return }
            colorTextField.text = backgroundColorString
            colorPickerView.backgroundColor = UIColor(hexString: backgroundColorString)
        case .add:
            interactor.randomizeColor()
        }
    }
    
    @IBAction func didTouchRandomButton(_ sender: Any) {
        interactor.randomizeColor()
    }
    
    @objc func didTextFieldChange(_ textField: UITextView) {
        guard let colorString = textField.text else { return }
        interactor.didTextFieldChange(as: colorString)
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
        guard let title = alertView.titleTextField.text,
              let description = alertView.descriptionTextField.text,
              let backgroundColor = colorPickerView.backgroundColor else { return }
        
        interactor.save(title: title,
                        description: description,
                        backgroundColor: backgroundColor)
        dismiss(animated: true, completion: nil)
    }
    
}

extension LabelAlertViewController: LabelAlertDisplayLogic {
    
    func displaySaveButton(as isEnabled: Bool) {
        alertView.saveButton.isEnabled = isEnabled
    }

    func displayColorTextField(with hexString: String) {
        colorTextField.text = hexString
    }
    
    func displayColorPickerView(with color: UIColor) {
        colorPickerView.backgroundColor = color
    }
    
}
