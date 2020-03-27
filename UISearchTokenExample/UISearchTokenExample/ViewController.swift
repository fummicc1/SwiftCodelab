//
//  ViewController.swift
//  UISearchTokenExample
//
//  Created by Fumiya Tanaka on 2020/03/23.
//  Copyright © 2020 Fumiya Tanaka. All rights reserved.
//

import UIKit

enum Hobby: String, OptionSet, Equatable {
    init() {
        self = .none
    }
    
    init(rawValue: String) {
        if rawValue.starts(with: "s") {
            if rawValue.starts(with: "sw") {
                self = .swift
            } else if rawValue.starts(with: "sc") {
                self = .scala
            } else {
                self = [.swift, .scala]
            }
        } else if rawValue.starts(with: "g") {
            self = .go
        } else if rawValue.starts(with: "d") {
            self = .dart
        } else if rawValue.starts(with: "j") {
            if rawValue.starts(with: "javas") {
                self = .javascript
            } else if rawValue.starts(with: "java") {
                self = .java
            } else {
                self = [.javascript, .java]
            }
        } else if rawValue.starts(with: "p") {
            self = .python
        } else if rawValue.starts(with: "e") {
            self = .elixir
        } else if rawValue.starts(with: "t") {
            self = .typescript
        } else if rawValue.starts(with: "h") {
            self = .haskell
        } else if rawValue.starts(with: "k") {
            self = .kotlin
        } else if rawValue.starts(with: "c") {
            if rawValue.starts(with: "cpp") {
                self = [.c, .cpp]
            } else if rawValue.starts(with: "cs") {
                self = [.c, .cs]
            } else {
                self = .c
            }
        } else if rawValue.starts(with: "r") {
            self = .rust
        }
        self = .none
    }
    
    mutating func formUnion(_ other: __owned Hobby) {
        self.insert(other)
    }
    
    mutating func formIntersection(_ other: Hobby) {
        if contains(other) {
            remove(other)
        }
    }
    
    mutating func formSymmetricDifference(_ other: __owned Hobby) {
        if contains(other) {
            remove(other)
        } else {
            insert(other)
        }
    }
    
    case swift
    case go
    case dart
    case javascript
    case python
    case scala
    case elixir
    case typescript
    case haskell
    case kotlin
    case java
    case c
    case cpp
    case cs
    case rust
    case none
}

class ViewController: UIViewController {
    @IBOutlet private weak var hobbySearchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

