//
//  TextFieldStyle.swift
//  PokeDemo
//
//  Created by Guerson on 2020-08-31.
//  Copyright © 2020 Itandehui. All rights reserved.
//

import Foundation
import UIKit

enum TextFieldStyle {
    case email
    case password
    
    var placeholder: String {
        switch self {
        case .email:
            return "example@email.com"
        default:
            return "Password"
        }
    }
    
    var selectedImageButton: ImageAsset {
        switch self {
        case .email:
            return ImageAsset.check
        case .password:
            return .eye
        }
    }
    
    var keyBoardType: UIKeyboardType {
        switch self {
        case .email:
            return .emailAddress
        case .password:
            return .alphabet
        }
    }
    
    var isSecure: Bool {
        return self == .password
    }
    
    var buttonEnabled: Bool {
        switch self {
        case .email:
            return false
        case .password:
            return true
        }
    }
}
