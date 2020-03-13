//
//  DispatchConcurrentQueueTests.swift
//  DispatchConcurrentQueueTests
//
//  Created by Fumiya Tanaka on 2020/03/14.
//  Copyright © 2020 Fumiya Tanaka. All rights reserved.
//

import XCTest
@testable import DispatchConcurrentQueue

class DispatchConcurrentQueueTests: XCTestCase {
    
    func testSerial() {
        measure {
            let model = Model()
            model.performSerial()
        }
    }
    
    func testConcurrent() {
        measure {
            let model = Model()
            model.performConcurrent()
        }
    }
    
    func testConcurrentWith() {
        measure {
            let model = Model()
            model.performConcurrentWithConcurrentPerform()
        }
    }
}
