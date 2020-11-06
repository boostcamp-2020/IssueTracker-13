//
//  FloatingButton.swift
//  IssueTracker
//
//  Created by 강병민 on 2020/11/02.
//

import UIKit

class FloatingButton: UIButton {

    override func awakeFromNib() {
        layer.cornerRadius = frame.height/2
        configureShadow()
    }
    
    private func configureShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = .zero
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 4.0
    }

}
