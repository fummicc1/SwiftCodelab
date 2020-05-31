//
//  FirstBuilder.swift
//  RIBsSample
//
//  Created by Fumiya Tanaka on 2020/05/31.
//  Copyright © 2020 Fumiya Tanaka. All rights reserved.
//

import RIBs

protocol FirstDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class FirstComponent: Component<FirstDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol FirstBuildable: Buildable {
    func build(withListener listener: FirstListener) -> FirstRouting
}

final class FirstBuilder: Builder<FirstDependency>, FirstBuildable {

    override init(dependency: FirstDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: FirstListener) -> FirstRouting {
        let component = FirstComponent(dependency: dependency)
        let viewController = FirstViewController()
        let interactor = FirstInteractor(presenter: viewController)
        interactor.listener = listener
        return FirstRouter(interactor: interactor, viewController: viewController)
    }
}
