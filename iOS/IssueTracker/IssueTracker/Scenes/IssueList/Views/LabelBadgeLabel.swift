//
//  LabelBadgeLabel.swift
//  IssueTracker
//
//  Created by 강병민 on 2020/10/29.
//

import UIKit

class LabelBadgeLabel: InsetLabel {
    
    func configure(with label: Label) {
        self.text = label.title
        self.backgroundColor = UIColor(hexString: label.backgroundColor ?? "#000000")
        self.textColor = UIColor(hexString: label.color ?? "#FFFFFF")
        //이 뒤는 color 설정하기
    }
    
}
