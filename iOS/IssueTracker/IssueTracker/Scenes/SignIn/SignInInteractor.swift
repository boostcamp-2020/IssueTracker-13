//
//  SignInInteractor.swift
//  IssueTracker
//
//  Created by 강병민 on 2020/11/04.
//

import Foundation

protocol SignInBuisnessLogic {
    func signInWithGitHub()
    func signInWithApple()
}

class SignInInteractor {
    
    weak var viewController: SignInDisplayLogic?
    
}

extension SignInInteractor: SignInBuisnessLogic {
    
    func signInWithGitHub() {
        
    }
    
    func signInWithApple() {
        
    }
    
}
