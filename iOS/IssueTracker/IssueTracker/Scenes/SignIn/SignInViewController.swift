//
//  SignInViewController.swift
//  IssueTracker
//
//  Created by 강병민 on 2020/11/04.
//

import UIKit
import AuthenticationServices

protocol SignInDisplayLogic: class {
    
}
class SignInViewController: UIViewController {

    @IBOutlet weak var loginStackView: UIStackView!
    let interactor = SignInInteractor()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.viewController = self
        setupProviderLoginView()
    }

    func setupProviderLoginView() {
        let authorizationButton = ASAuthorizationAppleIDButton()
        authorizationButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        authorizationButton.cornerRadius = 8.0
        authorizationButton.addTarget(self,
                                      action: #selector(handleAuthorizationAppleIDButtonPress),
                                      for: .touchUpInside)
        self.loginStackView.addArrangedSubview(authorizationButton)
    }
    
    @objc
    func handleAuthorizationAppleIDButtonPress() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        
        // user data 가져왔을때의 delegate 함수
        authorizationController.delegate = self.interactor
        
        // ASAuthorizationController를 보여줄 window 정하기
        authorizationController.presentationContextProvider = self
        
        // Sign-in with Apple dialog 보여주기
        authorizationController.performRequests()
    }
    
}

extension SignInViewController: SignInDisplayLogic {
    
}

extension SignInViewController: ASAuthorizationControllerPresentationContextProviding {
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
    
}
