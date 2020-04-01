//
//  Model.swift
//  PracticeRxTests
//
//  Created by Fumiya Tanaka on 2020/04/01.
//  Copyright © 2020 Fumiya Tanaka. All rights reserved.
//

import Foundation

extension ViewController {
    class Model {
        func validate(userName: String, password: String) -> InputValidationResult {
            var userNameError: UserNameInputError?
            var passwordError: PasswordInputError?
            
            if userName.isEmpty {
                userNameError = .empty
            }
            if password.isEmpty {
                passwordError = .empty
            } else if password.count < 6 {
                passwordError = .requireSixChars
            }
            
            switch (userNameError, passwordError) {
            case (let userNameError?, let passwordError?):
                return InputValidationResult.wrongBothUserNameAndPassword((userNameError, passwordError))
                
            case (let userNameError?, _):
                return InputValidationResult.wrongUserName(userNameError)
                
            case (_, let passwordError?):
                return InputValidationResult.wrongPassword(passwordError)
                
            default:
                return .success
            }
        }
    }
}
