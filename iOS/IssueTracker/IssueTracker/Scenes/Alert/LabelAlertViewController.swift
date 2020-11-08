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
    @IBOutlet weak var colorPickerView: UIView!
    
    weak var delegate: LabelAlertDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        alertView.stackView.addArrangedSubview(colorView)
        alertView.closeButton.addTarget(self, action: #selector(didTouchCloseButton), for: .touchUpInside)
        alertView.resetButton.addTarget(self, action: #selector(didTouchResetButton), for: .touchUpInside)
        alertView.saveButton.addTarget(self, action: #selector(didTouchSaveButton), for: .touchUpInside)
        colorTextField.addTarget(self, action: #selector(didTextFieldChange(_:)), for: .editingChanged)
    }
    
    func configure(_ mode: AlertMode, label: Label?) {
        self.mode = mode
        switch mode {
        case .edit:
            self.id = label?.id
            alertView.titleTextField.text = label?.title
            alertView.descriptionTextField.text = label?.description
            
            guard let backgroundColorString = label?.backgroundColor else { return }
            colorTextField.text = backgroundColorString
            colorPickerView.backgroundColor = UIColor(hexString: backgroundColorString)
        default:
            break
        }
    }
    
    func isValidate(_ string: String) -> Bool {
        let otherChars = string.dropFirst()
        for char in otherChars where !char.isHexDigit {
            return false
        }
        return true
    }
    
    @IBAction func didTouchRandomButton(_ sender: Any) {
        colorPickerView.backgroundColor = generateRandomColor()
        colorTextField.text = colorPickerView.backgroundColor?.toHexString()
    }
    
    func generateRandomColor() -> UIColor {
        return UIColor(red: .random(in: 0...1),
                       green: .random(in: 0...1),
                       blue: .random(in: 0...1),
                       alpha: 1.0)
    }
    
    @objc func didTextFieldChange(_ textField: UITextView) {
        guard let colorString = textField.text else { return }
        
        if colorString.isEmpty {
            textField.text = "#"
        } else if colorString.count == 7 {
            if isValidate(colorString) {
                colorPickerView.backgroundColor = UIColor(hexString: colorString)
                alertView.saveButton.isEnabled = true
            } else {
                alertView.saveButton.isEnabled = false
            }
        } else {
            alertView.saveButton.isEnabled = false
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
        guard let color = colorTextField.text else { return }
        let backgroundColor = generateTextColor()
        let label: Labelable
        switch mode {
        case .add:
            label = PostLabel(title: alertView.titleTextField.text, description: alertView.descriptionTextField.text, color: color, backgroundColor: backgroundColor)
        case .edit:
            guard let id = id else { return }
            label = PutLabel(id: id, title: alertView.titleTextField.text, description: alertView.descriptionTextField.text, color: color, backgroundColor: backgroundColor)
        }
        
        delegate?.didTouchSaveButton(label: label, mode: mode)
    }
    
    func generateTextColor() -> String {
        guard let isDark = colorPickerView.backgroundColor?.isDarkColor else { return "#000000"}
        return isDark ? "#ffffff" : "#000000"
    }
    
}
