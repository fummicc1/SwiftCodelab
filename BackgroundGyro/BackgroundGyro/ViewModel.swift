//
//  ViewModel.swift
//  BackgroundGyro
//
//  Created by Fumiya Tanaka on 2020/04/20.
//  Copyright © 2020 Fumiya Tanaka. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol ViewModelType {
    
    var output: ViewModel.Output { get }
    init(input: ViewModel.Input, dependency: ViewModel.Dependency, disposeBag: DisposeBag)
}

class ViewModel: ViewModelType {
    
    struct Input {
    }
    
    struct Output {
    }
    
    struct Dependency {
    }
    
    var output: Output
    
    required init(input: Input, dependency: Dependency = .init(), disposeBag: DisposeBag = .init()) {
        output = .init()
    }
}
