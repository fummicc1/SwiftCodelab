//
//  ModelValidation.swift
//  PracticeRxTests
//
//  Created by Fumiya Tanaka on 2020/04/01.
//  Copyright © 2020 Fumiya Tanaka. All rights reserved.
//

import Quick
import Nimble
import RxSwift
import RxTest
@testable import PracticeRxTests

class ModelValidationSpec: QuickSpec {
    
    override func spec() {
        describe("Model#validate") {
            
            var scheduler: TestScheduler = TestScheduler(initialClock: 0)
            let model: ViewController.Model = ViewController.Model()
            
            beforeEach {
                scheduler = TestScheduler(initialClock: 0)
            }
            
            context("when password is empty but userName is fulfill") {
                
                it("returns true") {
                    let userNameObservables = scheduler.createColdObservable([
                        Recorded.next(0, ("Test", "")),
                        Recorded.next(15, ("Test", "TestPassword"))
                    ])
                    let response = scheduler.start(created: 0, subscribed: 0, disposed: 30) {
                        userNameObservables.map { model.validate(userName: $0.0, password: $0.1) }
                    }
                    
                    let expected: [Recorded<Event<ViewController.InputValidationResult>>] = [
                        Recorded.next(0, ViewController.InputValidationResult.wrongPassword(.empty)),
                        Recorded.next(15, ViewController.InputValidationResult.success),
                    ]
                    
                    // 時間も同じじゃないといけない
                    expect(response.events).to(equal(expected))
                }
            }
        }
        
    }
}
