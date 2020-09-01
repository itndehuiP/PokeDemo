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
            return ImageAsset.pokeballBlack
        case .password:
            return .pokeballRed
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
}
