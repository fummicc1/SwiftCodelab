//
//  RootViewController.swift
//  PageSheetUITransitionView
//
//  Created by Fumiya Tanaka on 2020/03/17.
//  Copyright © 2020 Fumiya Tanaka. All rights reserved.
//

import UIKit

class RootViewController: UIViewController, UIViewControllerTransitioningDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        transitioningDelegate = self
    }
    
    @IBAction private func sameTransitionViewActionTapped() {
        guard let destination = storyboard?.instantiateViewController(withIdentifier: "SameTransitionViewBackViewController") as? SameTransitionViewBackViewController else {
            fatalError()
        }
        destination.transitioningDelegate = destination
        destination.modalPresentationStyle = .custom
        present(destination, animated: true, completion: nil)
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        ModalTransitioningDelegateViewController(presenting: true)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        ModalTransitioningDelegateViewController(presenting: false)
    }
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        UIPresentationController(presentedViewController: presented, presenting: presenting)
    }
}
