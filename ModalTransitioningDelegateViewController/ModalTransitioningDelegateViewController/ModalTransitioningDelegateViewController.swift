//
//  SameTransitionViewBackViewController.swift
//  PageSheetUITransitionView
//
//  Created by Fumiya Tanaka on 2020/03/17.
//  Copyright © 2020 Fumiya Tanaka. All rights reserved.
//

import UIKit

class ModalTransitioningDelegateViewController: NSObject, UIViewControllerAnimatedTransitioning {
    
    let presenting: Bool
    
    init(presenting: Bool) {
        self.presenting = presenting
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let from = transitionContext.viewController(forKey: .from)?.view,
            let to = transitionContext.viewController(forKey: .to)?.view else {
                return
        }
        let container = transitionContext.containerView
        if presenting {
            to.frame.origin = .init(x: 0, y: from.frame.height)
            container.addSubview(to)
        } else {
            from.frame.origin = .init(x: 0, y: 0)
            container.insertSubview(from, belowSubview: to)
        }
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: { [weak self] in
            if self?.presenting == true {
                to.frame.origin = .init(x: 0, y: 0)
            } else {
                from.frame.origin = .init(x: 0, y: from.frame.height)
            }
        }, completion: { isCompleted in
            transitionContext.completeTransition(isCompleted)
        })
    }
}

class SameTransitionViewBackViewController: UIViewController, UIViewControllerTransitioningDelegate {
    @IBAction private func back() {
        dismiss(animated: true, completion: nil)
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
