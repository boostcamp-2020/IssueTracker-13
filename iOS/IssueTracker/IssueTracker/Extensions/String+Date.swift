//
//  String+Date.swift
//  IssueTracker
//
//  Created by 강병민 on 2020/11/07.
//

import Foundation

extension String {
    
    func toDate() -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        return formatter.date(from: self)
    }
    
}
