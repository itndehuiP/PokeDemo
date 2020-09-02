//
//  LoginViewController.swift
//  PokeDemo
//
//  Created by Guerson on 2020-08-31.
//  Copyright © 2020 Itandehui. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var mailContainerTextField: ContainerTextField!
    @IBOutlet weak var passwordContainerTextField: ContainerTextField!
    @IBOutlet private weak var scrollView: ScrollKeyboardAvoiding!
    @IBOutlet weak var loginButton: LoginButton!
    
    
    private var viewModel = LoginViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    private func configureView() {
        hideKeyboardWhenTappedAround()
        mailContainerTextField.set(with: .email, action: { self.passwordContainerTextField.callBecomeFirstResponder() })
        passwordContainerTextField.set(with: .password, action: { self.passwordContainerTextField.callResignFirstResponder() })
        mailContainerTextField.delegate = self
        passwordContainerTextField.delegate = self
        loginButton.delegate = self
        viewModel.delegate = self
    }


    private func tryLogin(){
        viewModel.tryLogin()
    }
}

extension LoginViewController: ContainerTextFieldDelegate {
    func textFieldValidate(type: TextFieldStyle, text: String?, valid: Bool) {
            switch type {
            case .email:
                viewModel.mailValidation = valid
                viewModel.mail = text
            case .password:
                viewModel.passwordValidation = valid
                viewModel.password = text
            }
        checkButtonAvailability()
    }
    
    private func checkButtonAvailability(){
        loginButton.set(toEnable: viewModel.inputValidation())
    }
    
}

//MARK: Keyboard Avoiding
extension LoginViewController {
    private func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc private func dismissKeyboard() {
        self.scrollView.setContentOffset(CGPoint.zero, animated: true)
        view.endEditing(true)
    }
}

//MARK: Login button delegate
extension LoginViewController: LoginButtonDelegate {
    func onButtonTapped() {
        self.tryLogin()
    }
}

//MARK: LoginViewModel Delegate
extension LoginViewController : LoginViewModelDelegate {
    func failedLogin(error: ResponseError) {
        let action = UIAlertAction(title: "OK", style: .default)
        displayAlert(with: "Error", message: error.description, actions: [action])
    }
    
    func successfullLogin(token: String?) {
        self.navigationController?.setRoot(vc: .home)
    }
    
}
