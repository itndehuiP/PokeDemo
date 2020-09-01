//
//  ContainerTextFieldViewModel.swift
//  PokeDemo
//
//  Created by Guerson on 2020-08-31.
//  Copyright © 2020 Itandehui. All rights reserved.
//

import Foundation

struct ContainerTextFieldViewModel {
    var textFieldStyle: TextFieldStyle = .email

    func checkValidation(with text: String?) -> Bool {
        switch textFieldStyle {
        case .email:
            return ValidationChecker.validateEmail(mail: text)
        case .password:
            return ValidationChecker.validatePassword(password: text)
        }
    }
}
