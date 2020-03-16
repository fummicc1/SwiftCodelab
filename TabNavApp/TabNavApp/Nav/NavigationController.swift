//
//  NavViewController.swift
//  TabNavApp
//
//  Created by Fumiya Tanaka on 2020/03/15.
//  Copyright © 2020 Fumiya Tanaka. All rights reserved.
//

import UIKit

final class NavigationAnimator: UIPercentDrivenInteractiveTransition {
}

final class TransitionCoordinator: NSObject, UINavigationControllerDelegate {
    
    weak var navigationAnimator: NavigationAnimator?
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == .pop {
            return TransitionAnimator(presenting: false)
        } else if operation == .push {
            return TransitionAnimator(presenting: true)
        }
        return nil
    }
    
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        navigationAnimator
    }
}

final class TransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    private let presenting: Bool
    
    init(presenting: Bool) {
        self.presenting = presenting
        super.init()
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        TimeInterval(UINavigationController.hideShowBarDuration)
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let sourceView = transitionContext.view(forKey: .from),
            let destinationView = transitionContext.view(forKey: .to)  else {
            return
        }
        
        let duration = transitionDuration(using: transitionContext)
        let container = transitionContext.containerView
        if presenting {
            container.addSubview(destinationView)
        } else {
            container.insertSubview(destinationView, belowSubview: sourceView)
        }
        let destinationFrame = destinationView.frame
        destinationView.frame = CGRect(x: presenting ? destinationView.frame.width : -destinationView.frame.width, y: destinationView.frame.origin.y, width: destinationView.frame.width, height: destinationView.frame.height)
        
        let animations = {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5) { [weak self] in
                destinationView.alpha = 1
                if self?.presenting == true {
                    sourceView.alpha = 0
                }
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1) { [weak self] in
                let presenting: Bool = self?.presenting ?? false
                destinationView.frame = destinationFrame
                sourceView.frame = CGRect(x: presenting ? -sourceView.frame.width : sourceView.frame.width, y: sourceView.frame.origin.y, width: sourceView.frame.width, height: sourceView.frame.height)
                if presenting {
                    sourceView.alpha = 0
                }
            }
        }
        
        UIView.animateKeyframes(withDuration: duration, delay: 0, options: .calculationModeCubic, animations: animations) { completed in
            if transitionContext.transitionWasCancelled {
                destinationView.removeFromSuperview()
            }
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
    
    
}

class NavigationController: UINavigationController {

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
        addCustomTransitioning()
        navigationBar.isTranslucent = false
    }
}

extension NavigationController {
    static private var coordinatorHelperKey = "UINavigationController.TransitionCoordinatorHelper"
    
    var transitionCoordinatorHelper: TransitionCoordinator? {
        objc_getAssociatedObject(self, &NavigationController.coordinatorHelperKey) as? TransitionCoordinator
    }
    
    func addCustomTransitioning() {
        guard transitionCoordinatorHelper == nil else {
            return
        }
        
        let object = TransitionCoordinator()
        let nonAtomic = objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC
        objc_setAssociatedObject(self, &NavigationController.coordinatorHelperKey, object, nonAtomic)
        delegate = object
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGesturePerformed(sender:)))
        view.addGestureRecognizer(panGesture)
    }
    
    @objc private func panGesturePerformed(sender: UIPanGestureRecognizer) {
        guard let view = sender.view else {
            return
        }
        let percent = sender.translation(in: view).x / view.frame.width
        
        if sender.state == .began {
            let navigationAnimator = NavigationAnimator()
            transitionCoordinatorHelper?.navigationAnimator = navigationAnimator
            popViewController(animated: true)
        } else if sender.state == .changed {
            transitionCoordinatorHelper?.navigationAnimator?.update(percent)
        } else if sender.state == .ended {
            if percent > 0.5 && sender.state != .cancelled {
                transitionCoordinatorHelper?.navigationAnimator?.finish()
            } else {
                transitionCoordinatorHelper?.navigationAnimator?.cancel()
            }
            transitionCoordinatorHelper?.navigationAnimator = nil
        }
    }
}
