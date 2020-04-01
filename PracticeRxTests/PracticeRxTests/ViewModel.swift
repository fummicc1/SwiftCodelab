//
//  ViewModel.swift
//  PracticeRxTests
//
//  Created by Fumiya Tanaka on 2020/04/01.
//  Copyright © 2020 Fumiya Tanaka. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

extension ViewController {
    
    enum InputValidationResult: Equatable {
        static func == (lhs: ViewController.InputValidationResult, rhs: ViewController.InputValidationResult) -> Bool {
            switch (lhs, rhs) {
            case (ViewController.InputValidationResult.success, .success):
                return true
                
            case (ViewController.InputValidationResult.wrongUserName, .wrongUserName):
                return true
                
            case (ViewController.InputValidationResult.wrongPassword, .wrongPassword):
                return true
                
            case (ViewController.InputValidationResult.wrongBothUserNameAndPassword, .wrongBothUserNameAndPassword):
                return true
                
            default:
                return false
            }
        }
        
        case success
        case wrongUserName(UserNameInputError)
        case wrongPassword(PasswordInputError)
        case wrongBothUserNameAndPassword((UserNameInputError, PasswordInputError))
    }
    
    enum UserNameInputError: Error {
        case empty
    }
    
    enum PasswordInputError: Error {
        case empty
        case requireSixChars
    }
    
    class ViewModel {
        
        private let inputValidationResultRelay: PublishRelay<InputValidationResult> = .init()
        var inputValidationResult: Observable<InputValidationResult> {
            inputValidationResultRelay.asObservable()
        }
        private let model: Model
        private let disposeBag = DisposeBag()
        
        init(
            userName: Observable<String>,
            password: Observable<String>,
            model: Model = Model()
        ) {
            self.model = model
            Observable
                .combineLatest(userName, password)
                .map ({ (userName, password) -> InputValidationResult in
                    model.validate(userName: userName, password: password)
                })
                .bind(to: inputValidationResultRelay)
            .disposed(by: disposeBag)
        }
    }
}
