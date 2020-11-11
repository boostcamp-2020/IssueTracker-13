//
//  SignInInteractor.swift
//  IssueTracker
//
//  Created by 강병민 on 2020/11/04.
//

import Foundation
import AuthenticationServices
import Alamofire

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
    
    func login(id: String, password: String) {
        let testRequest = SignInRequest(authType: "local",
                                        email: id,
                                        password: password)

        API.shared.post(data: testRequest, to: .signIn) { (result: Result<SignInResponse, Error>) in
            switch result {
            case .success(let result):
                var userToken = UserToken()
                userToken.name = result.name
                userToken.token = result.token
                self.viewController?.displayIssueViewController()
            case .failure(let error):
                self.viewController?.displayAlert()
            }

        }

//        API.shared.signIn(data: testRequest, to: .signIn) { (result : ) in
//
//            switch result {
//            case .success(let response):
//                print("\(response.userName), \(response.token)")
//            case .failure:
//                print("fail to login!!!!")
//            }
//
//        }
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
