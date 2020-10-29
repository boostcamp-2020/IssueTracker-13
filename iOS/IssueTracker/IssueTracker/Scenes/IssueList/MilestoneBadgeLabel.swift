//
//  MilestoneBadgeLabel.swift
//  IssueTracker
//
//  Created by 강병민 on 2020/10/29.
//

import UIKit

class MilestoneBadgeLabel: InsetLabel {
    
    func configure(with text: String) {
        self.text = text
        textColor = UIColor.darkGray
        layer.borderColor = UIColor.darkGray.cgColor
        layer.borderWidth = 1.0
    }
    
}
