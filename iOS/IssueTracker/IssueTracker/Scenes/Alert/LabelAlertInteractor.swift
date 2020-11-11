//
//  LabelAlertInteractor.swift
//  IssueTracker
//
//  Created by 강병민 on 2020/11/08.
//

import UIKit

protocol LabelAlertDelegate: class {
    func didTouchSaveButton(label: Labelable, mode: AlertMode)
}

protocol LabelAlertBuisnessLogic {
    func randomizeColor()
    func save(title: String, description: String, backgroundColor: UIColor)
    func didTextFieldChange(as hexString: String)
}

class LabelAlertInteractor {
    
    weak var delegate: LabelAlertDelegate?
    weak var viewController: LabelAlertDisplayLogic?
    var mode: AlertMode?
    var id: Int?
    
    func isValidate(_ string: String) -> Bool {
        let otherChars = string.dropFirst()
        for char in otherChars where !char.isHexDigit {
            return false
        }
        return true
    }
    
    func generateRandomColor() -> UIColor {
        return UIColor(red: .random(in: 0...1),
                       green: .random(in: 0...1),
                       blue: .random(in: 0...1),
                       alpha: 1.0)
    }
    
    func generateTextColor(from color: UIColor) -> String {
        return color.isDarkColor ? "#ffffff" : "#000000"
    }
    
}

extension LabelAlertInteractor: LabelAlertBuisnessLogic {
    
    func randomizeColor() {
        let randomColor = generateRandomColor()
        viewController?.displayColorPickerView(with: randomColor)
        viewController?.displayColorTextField(with: randomColor.toHexString())
    }
    
    func save(title: String, description: String, backgroundColor: UIColor) {
        guard let mode = mode else { return }
        let textColorString = generateTextColor(from: backgroundColor)
        let backgroundColorString = backgroundColor.toHexString()
        let label: Labelable
        switch mode {
        case .add:
            label = PostLabel(title: title,
                              description: description,
                              color: textColorString,
                              backgroundColor: backgroundColorString)
        case .edit:
            guard let id = id else { return }
            label = Label(id: id,
                             title: title,
                             description: description,
                             color: textColorString,
                             backgroundColor: backgroundColorString)
        }
        delegate?.didTouchSaveButton(label: label, mode: mode)
    }
    
    func didTextFieldChange(as colorString: String) {
        if colorString.isEmpty {
            viewController?.displayColorTextField(with: "#")
        } else if colorString.count == 7 {
            if isValidate(colorString) {
                viewController?.displayColorPickerView(with: UIColor(hexString: colorString))
                viewController?.displaySaveButton(as: true)
            } else {
                viewController?.displaySaveButton(as: false)
            }
        } else {
            viewController?.displaySaveButton(as: false)
        }
    }
    
}
