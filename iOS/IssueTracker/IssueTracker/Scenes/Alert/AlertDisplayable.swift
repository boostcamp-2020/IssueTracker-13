//
//  AlertPresentable.swift
//  IssueTracker
//
//  Created by 강병민 on 2020/11/05.
//

import Foundation

enum AlertMode {
    case add, edit
}
protocol AlertDisplayable {
    func displayAlert()
}
