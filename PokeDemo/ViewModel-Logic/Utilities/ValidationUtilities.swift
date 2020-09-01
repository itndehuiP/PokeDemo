//
//  ValidationUtilities.swift
//  PokeDemo
//
//  Created by Guerson on 2020-08-31.
//  Copyright © 2020 Itandehui. All rights reserved.
//

import Foundation

class ValidationChecker {
    public static func validateEmail(mail:String?) -> Bool {
        guard let mail = mail else {
            return false
        }
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            return emailTest.evaluate(with: mail)
    }
    
    public static func validatePassword(password: String?) -> Bool {
        guard let password = password else {
            return false
        }
         return ( self.containsCharacter(word: password, chars: .uppercaseLetters)
                     && self.containsCharacter(word: password, chars: .lowercaseLetters)
                     && self.containsCharacter(word: password, chars: .decimalDigits)
                     && password.count >= 8)

    }
    
    public static func containsCharacter(word: String, chars: CharacterSet) -> Bool {
        if word.rangeOfCharacter(from: chars) == nil {
            return false
        }
        return true
    }
}
