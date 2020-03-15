//
//  ViewController.swift
//  TabNavApp
//
//  Created by Fumiya Tanaka on 2020/03/15.
//  Copyright © 2020 Fumiya Tanaka. All rights reserved.
//

import UIKit

class TabViewController: UIViewController {

    weak var currentChildViewController: NavViewController? {
        didSet {
            if oldValue == currentChildViewController {
                return
            }
            guard let currentChildViewController = currentChildViewController else {
                return
            }
            addChild(currentChildViewController)
            currentChildViewController.didMove(toParent: self)
            view.addSubview(currentChildViewController.view)
            currentChildViewController.view.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                bottomStackView.topAnchor.constraint(equalTo: currentChildViewController.view.bottomAnchor),
                view.topAnchor.constraint(equalTo: currentChildViewController.view.topAnchor),
                view.leadingAnchor.constraint(equalTo: currentChildViewController.view.leadingAnchor),
                view.trailingAnchor.constraint(equalTo: currentChildViewController.view.trailingAnchor)
            ])
        }
    }
    
    @IBOutlet private weak var bottomStackView: UIStackView!
    @IBOutlet private weak var firstTabButton: TabButton!
    @IBOutlet private weak var secondTabButton: TabButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.translatesAutoresizingMaskIntoConstraints = false
        firstTabButton.action = { [weak self] in
            if let firstVC = self?.children.compactMap({ $0 as? NavViewController }).first(where: { $0.rootViewController is FirstViewController }) {
                self?.view.bringSubviewToFront(firstVC.view)
                return
            }
            guard let firstVC = UIStoryboard(name: "First", bundle: nil).instantiateInitialViewController (creator: { coder in
                return FirstViewController(coder: coder, input: "First", dependency: FirstModel())
            }) else {
                return
            }
            let currentChildViewController = NavViewController(rootViewController: firstVC)
            self?.currentChildViewController = currentChildViewController
        }
        secondTabButton.action = { [weak self] in
            if let secondVC = self?.children.compactMap({ $0 as? NavViewController }).first(where: { $0.rootViewController is SecondViewController }) {
                self?.view.bringSubviewToFront(secondVC.view)
                return
            }
            guard let secondVC = UIStoryboard(name: "Second", bundle: nil).instantiateInitialViewController (creator: { coder in
                return SecondViewController(coder: coder, input: "Second", dependency: SecondModel())
            }) else {
                return
            }
            let currentChildViewController = NavViewController(rootViewController: secondVC)
            self?.currentChildViewController = currentChildViewController
        }
        
        // initially set up.
        guard let firstVC = UIStoryboard(name: "First", bundle: nil).instantiateInitialViewController (creator: { coder in
            return FirstViewController(coder: coder, input: "First", dependency: FirstModel())
        }) else {
            return
        }
        let currentChildViewController = NavViewController(rootViewController: firstVC)
        self.currentChildViewController = currentChildViewController
    }
}

class TabButton: UIButton {
    
    var action: (() -> Void)?

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        action?()
    }
}
