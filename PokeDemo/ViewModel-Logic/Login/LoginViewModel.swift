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
    
    func inputValidation() -> Bool {
        return mailValidation && passwordValidation
    }
}
