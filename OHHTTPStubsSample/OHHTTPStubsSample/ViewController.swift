//
//  ViewController.swift
//  OHHTTPStubsSample
//
//  Created by Fumiya Tanaka on 2020/04/03.
//  Copyright © 2020 Fumiya Tanaka. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private let model: Model = Model()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        model.getComemnt()
    }


}

