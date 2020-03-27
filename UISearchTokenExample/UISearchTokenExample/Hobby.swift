//
//  Hobby.swift
//  UISearchTokenExample
//
//  Created by Fumiya Tanaka on 2020/03/27.
//  Copyright © 2020 Fumiya Tanaka. All rights reserved.
//

import Foundation

enum Hobby: String, CaseIterable, Equatable {
    static func create(from text: String) -> Set<Hobby> {
        if text.starts(with: "s") {
            if text.starts(with: "sw") {
                return [.swift]
            } else if text.starts(with: "sc") {
                return [.scala]
            } else {
                return [.swift, .scala]
            }
        } else if text.starts(with: "g") {
            return [.go]
        } else if text.starts(with: "d") {
            return [.dart]
        } else if text.starts(with: "j") {
            if text.starts(with: "javas") {
                return [.javascript]
            } else if text.starts(with: "java") {
                return [.java]
            } else {
                return [.java, .javascript]
            }
        } else if text.starts(with: "p") {
            return [.python]
        } else if text.starts(with: "e") {
            return [.elixir]
        } else if text.starts(with: "t") {
            return [.typescript]
        } else if text.starts(with: "h") {
            return [.haskell]
        } else if text.starts(with: "k") {
            return [.kotlin]
        } else if text.starts(with: "c") {
            if text.starts(with: "cpp") {
                return [.cpp]
            } else if text.starts(with: "cs") {
                return [.cs]
            } else {
                return [.c, .cpp, .cs]
            }
        } else if text.starts(with: "r") {
            return [.rust]
        }
        return []
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
}
