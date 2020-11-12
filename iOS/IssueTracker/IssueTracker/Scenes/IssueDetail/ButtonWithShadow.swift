//
//  ButtonWithShadow.swift
//  IssueTracker
//
//  Created by jaejeon on 2020/11/11.
//

import UIKit

class ButtonWithShadow: UIButton {

    override func draw(_ rect: CGRect) {
        super.draw(rect)
            updateLayerProperties()
    }

    func updateLayerProperties() {
        self.layer.cornerRadius = 1.0
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = 2
        self.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.layer.shadowOpacity = 0.3
        self.layer.backgroundColor = UIColor.white.cgColor
    }

}
