//
//  SignInInteractor.swift
//  IssueTracker
//
//  Created by 강병민 on 2020/11/04.
//

import Foundation
import AuthenticationServices

protocol SignInBuisnessLogic {
    func signInWithGitHub()
    func signInWithApple()
}

class SignInInteractor: NSObject{
//    private let signInSucceeded: (Bool) -> Void
    weak var viewController: SignInDisplayLogic?
    
}

extension SignInInteractor: SignInBuisnessLogic {
    
    func signInWithGitHub() {
        
    }
    
    func signInWithApple() {
        
    }
    
    func registerNewAccount(credential : ASAuthorizationAppleIDCredential) {
        
        UserDefaults.standard.set(credential.user, forKey: "appleUserID")
    }
    
    func signInWithExistingAccount(credential: ASAuthorizationAppleIDCredential) {
        
    }
    
}

extension SignInInteractor: ASAuthorizationControllerDelegate {
    
    func authorizationController(controller: ASAuthorizationController,
                                 didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            if let _ = appleIDCredential.email, let _ = appleIDCredential.fullName {
              registerNewAccount(credential: appleIDCredential)
            } else {
              signInWithExistingAccount(credential: appleIDCredential)
            }
        case let passwordCredential as ASPasswordCredential:
            print(passwordCredential)
        default:
            break
        }
    }
    
}
