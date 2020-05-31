//
//  FirstViewController.swift
//  RIBsSample
//
//  Created by Fumiya Tanaka on 2020/05/31.
//  Copyright © 2020 Fumiya Tanaka. All rights reserved.
//

import RIBs
import RxSwift
import UIKit

protocol FirstPresentableListener: class {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class FirstViewController: UIViewController, FirstPresentable, FirstViewControllable {

    weak var listener: FirstPresentableListener?
}
