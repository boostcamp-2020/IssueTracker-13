//
//  SignInViewController.swift
//  IssueTracker
//
//  Created by 강병민 on 2020/11/04.
//

import UIKit
import AuthenticationServices

protocol SignInDisplayLogic: class {
    func displayIssueViewController()
    func displayAlert()
}
class SignInViewController: UIViewController {

    @IBOutlet weak var loginStackView: UIStackView!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    let interactor = SignInInteractor()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.viewController = self
        setupProviderLoginView()
    }
    
    @IBAction func didTouchLoginButton(_ sender: Any) {
        guard let id = idTextField.text ,
              let password = passwordTextField.text else { return }
        interactor.login(id: id, password: password)
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
    
    func displayIssueViewController() {
        performSegue(withIdentifier: "showIssueListViewController", sender: nil)
    }
    
    func displayAlert() {
        let alert = UIAlertController(title: "존재하지 않는 회원입니다", message: "아이디와 비밀번호를 다시 확인해주세요", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}

extension SignInViewController: ASAuthorizationControllerPresentationContextProviding {
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
    
}
