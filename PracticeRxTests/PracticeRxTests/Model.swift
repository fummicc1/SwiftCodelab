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
            if userName.isEmpty, password.isEmpty {
                return .wrongBothUserNameAndPassword((UserNameInputError.empty, PasswordInputError.empty))
            } else if userName.isEmpty, password.count < 6 {
                return .wrongBothUserNameAndPassword((UserNameInputError.empty, PasswordInputError.requireSixChars))
            } else if userName.isEmpty {
                return .wrongUserName(.empty)
            } else if password.isEmpty {
                return .wrongPassword(.empty)
            }
            return .success
        }
    }
}
