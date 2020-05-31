//
//  FirstInteractor.swift
//  RIBsSample
//
//  Created by Fumiya Tanaka on 2020/05/31.
//  Copyright © 2020 Fumiya Tanaka. All rights reserved.
//

import RIBs
import RxSwift

protocol FirstRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol FirstPresentable: Presentable {
    var listener: FirstPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol FirstListener: class {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class FirstInteractor: PresentableInteractor<FirstPresentable>, FirstInteractable, FirstPresentableListener {

    weak var router: FirstRouting?
    weak var listener: FirstListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: FirstPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
}
