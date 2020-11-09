//
//  Date+String.swift
//  IssueTracker
//
//  Created by 강병민 on 2020/11/07.
//

import Foundation

extension Date {
    
    func toServerString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        return formatter.string(from: self)
    }

    func toCellString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일"
        return formatter.string(from: self)
    }
    
}
