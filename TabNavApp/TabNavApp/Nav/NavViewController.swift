//
//  NavViewController.swift
//  TabNavApp
//
//  Created by Fumiya Tanaka on 2020/03/15.
//  Copyright © 2020 Fumiya Tanaka. All rights reserved.
//

import UIKit

protocol NavigationAnimator: UIPercentDrivenInteractiveTransition {
}

class NavViewController: UINavigationController {

    var rootViewController: UIViewController {
        viewControllers[0]
    }
    
    @available(iOS 13, *)
    init<Input, Dependency>(rootViewController: RootViewController<Input, Dependency>) {
        super.init(rootViewController: rootViewController)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.isTranslucent = false
    }
}
