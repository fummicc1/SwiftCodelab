//
//  RootViewController.swift
//  TabNavApp
//
//  Created by Fumiya Tanaka on 2020/03/15.
//  Copyright © 2020 Fumiya Tanaka. All rights reserved.
//

import Foundation
import UIKit

class RootViewController<Input, Dependency>: UIViewController {
    
    let input: Input
    let dependency: Dependency
    
    // can init from Storyboard (since iOS 13)
    @available(iOS 13, *)
    init?(coder: NSCoder, input: Input, dependency: Dependency) {
        self.input = input
        self.dependency = dependency
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
}
