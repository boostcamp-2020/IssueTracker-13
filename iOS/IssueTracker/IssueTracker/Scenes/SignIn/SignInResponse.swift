//
//  SignInResponse.swift
//  IssueTracker
//
//  Created by 강병민 on 2020/11/09.
//

import Foundation

struct SignInResponse: Codable {
    let name, profile, token: String
}
