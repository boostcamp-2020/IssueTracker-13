//
//  UserInfo.swift
//  IssueTracker
//
//  Created by 강병민 on 2020/11/09.
//

import Foundation

@propertyWrapper
struct UserInfo {
    
    private let key: String
    
    var wrappedValue: String {
        get {
            UserDefaults.standard.string(forKey: key) ?? ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
    
    init(key: String) {
        self.key = key
    }
    
}

struct UserToken {
    @UserInfo(key: "name") var name: String
    @UserInfo(key: "token") var token: String
    @UserInfo(key: "profile") var profile: String
}
