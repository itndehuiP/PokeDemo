//
//  CheckContainerTextFieldDelegate.swift
//  PokeDemo
//
//  Created by Guerson on 2020-08-31.
//  Copyright © 2020 Itandehui. All rights reserved.
//

import Foundation

protocol ContainerTextFieldDelegate: class {
    func textFieldValidate(type: TextFieldStyle, text: String?, valid: Bool) 
}
