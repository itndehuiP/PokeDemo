//
//  LoginViewModel.swift
//  PokeDemo
//
//  Created by Guerson on 2020-08-31.
//  Copyright © 2020 Itandehui. All rights reserved.
//

import Foundation

struct LoginViewModel {
    var mailValidation = false
    var passwordValidation = false
    
    var mail: String?
    var password: String?
    
    weak var delegate: LoginViewModelDelegate?
    
    func inputValidation() -> Bool {
        return mailValidation && passwordValidation
    }
    
    func tryLogin() {
        if mail?.lowercased() == "yellow@mail.com" && password == "Yellow1234." {
            let token = "token"
            KeychainWrapper.standard.set(token, forKey: SystemConstant.sessionToken.rawValue)
            delegate?.successfullLogin(token: token)
        } else {
            delegate?.failedLogin(error: .invalidLogin)
        }

    }
}
