//
//  ViewController.swift
//  StructAnyObject
//
//  Created by Fumiya Tanaka on 2020/03/14.
//  Copyright © 2020 Fumiya Tanaka. All rights reserved.
//

import UIKit

struct Article {
    let id: Int
    let title: String
    let content: String
}

class Util {
    static func asClass(about target: Any) -> AnyObject? {
        target as? AnyObject // always succeed
    }
    
    static func isClass(about target: Any) -> Bool {
        type(of: target) is AnyObject.Type
    }
}

class ViewController: UIViewController {

    private let article: Article = Article(id: 0, title: "title", content: "content")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let value = Util.asClass(about: article)
        print(value) // not nil.
        print(Util.isClass(about: article)) // expected
    }
}

