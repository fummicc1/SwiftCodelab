//
//  FirstRouter.swift
//  RIBsSample
//
//  Created by Fumiya Tanaka on 2020/05/31.
//  Copyright © 2020 Fumiya Tanaka. All rights reserved.
//

import RIBs

protocol FirstInteractable: Interactable {
    var router: FirstRouting? { get set }
    var listener: FirstListener? { get set }
}

protocol FirstViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class FirstRouter: ViewableRouter<FirstInteractable, FirstViewControllable>, FirstRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: FirstInteractable, viewController: FirstViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
