//
//  ViewController.swift
//  PracticeRxTests
//
//  Created by Fumiya Tanaka on 2020/04/01.
//  Copyright © 2020 Fumiya Tanaka. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    @IBOutlet private weak var validationLabel: UILabel!
    @IBOutlet private weak var userNameTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    
    private var viewModel: ViewModel!
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ViewModel(
            userName: userNameTextField.rx.text.orEmpty.asObservable(),
            password: passwordTextField.rx.text.orEmpty.asObservable()
        )
        viewModel
            .inputValidationResult
            .subscribe(onNext: { [weak self] validationResult in
                switch validationResult {
                case .success:
                    self?.validationLabel.text = "Good!"
                    
                case .wrongBothUserNameAndPassword((_, let passwordError)):
                    if passwordError == .empty {
                        self?.validationLabel.text = "ユーザー名とパスワードが未入力です"
                    } else if passwordError == .requireSixChars {
                        self?.validationLabel.text = "ユーザー名が未入力です。パスワードは6文字以上で登録をしてください。"
                    }
                    
                case .wrongPassword(let error):
                    if error == .empty {
                        self?.validationLabel.text = "パスワードが未入力です"
                    } else if error == .requireSixChars {
                        self?.validationLabel.text = "パスワードは6文字以上で登録をしてください。"
                    }
                    
                case .wrongUserName:
                    self?.validationLabel.text = "ユーザー名が未入力です"
                }
            })
            .disposed(by: disposeBag)
        
        viewModel
            .inputValidationResult
            .map ({ result -> UIColor in
                if case InputValidationResult.success = result {
                    return UIColor.label
                } else {
                    return UIColor.systemRed
                }
            })
            .bind(to: validationLabel.rx.textColor)
            .disposed(by: disposeBag)
    }
}

extension Reactive where Base: UILabel {
    var textColor: Binder<UIColor> {
        Binder<UIColor>(base) { (base, color) in
            base.textColor = color
        }
    }
}
