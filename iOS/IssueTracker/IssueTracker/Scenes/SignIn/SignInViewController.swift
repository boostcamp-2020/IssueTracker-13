//
//  SignInViewController.swift
//  IssueTracker
//
//  Created by 강병민 on 2020/11/04.
//

import UIKit

protocol SignInDisplayLogic: class {
}
class SignInViewController: UIViewController {

    let interactor = SignInInteractor()
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.viewController = self
    }

}

extension SignInViewController: SignInDisplayLogic {
    
}
