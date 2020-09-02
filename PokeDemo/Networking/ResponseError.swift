//
//  ResponseError.swift
//  PokeDemo
//
//  Created by Guerson on 2020-09-02.
//  Copyright © 2020 Itandehui. All rights reserved.
//

import Foundation

enum ResponseError: Error {
    case parseError
    case invalidLogin
    
    var description: String {
        "Email or pasword incorrect"
    }
}
