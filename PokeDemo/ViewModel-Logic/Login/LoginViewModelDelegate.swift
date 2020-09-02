//
//  LoginViewModelDelegate.swift
//  PokeDemo
//
//  Created by Guerson on 2020-09-02.
//  Copyright © 2020 Itandehui. All rights reserved.
//

import Foundation

protocol LoginViewModelDelegate: class {
    func successfullLogin(token: String?)
    func failedLogin(error: ResponseError)
}
