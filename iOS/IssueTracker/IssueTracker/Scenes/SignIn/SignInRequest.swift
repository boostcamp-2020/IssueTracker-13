//
//  SignInRequest.swift
//  IssueTracker
//
//  Created by 강병민 on 2020/11/09.
//

import Foundation

struct SignInRequest: Codable {
    let authType, email, password: String
}
