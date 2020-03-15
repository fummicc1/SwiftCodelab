//
//  FirstViewController.swift
//  TabNavApp
//
//  Created by Fumiya Tanaka on 2020/03/15.
//  Copyright © 2020 Fumiya Tanaka. All rights reserved.
//

import UIKit

class FirstModel { }

class FirstViewController: RootViewController<String, FirstModel>  {

    @IBOutlet private weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = input
    }
}
