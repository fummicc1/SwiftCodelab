//
//  ViewController.swift
//  DispatchConcurrentQueue
//
//  Created by Fumiya Tanaka on 2020/03/14.
//  Copyright © 2020 Fumiya Tanaka. All rights reserved.
//

import UIKit
import Dispatch
import DispatchIntrospection

class Model {
    
    private var serialQueues: [DispatchQueue] = []
    private var concurrentQueues: [DispatchQueue] = []
    
    func perform() {
        // GCD cannot stop excution.
        performSerial()
        performConcurrent()
        
        // It may be good to use `concurrentPerform` when we have to create many concurrent queues.
        performConcurrentWithConcurrentPerform()
        
        // After creating threads, they becomes pool threads.
        // Some of them may be deallocated (workq_kernreturn).
        
        // ---
    }
    
    func performConcurrentWithConcurrentPerform() {
        DispatchQueue.concurrentPerform(iterations: 100) { [weak self] index in
            self?.excute()
            if index == 99 {
                print("concurrentPerform_done")
            }
        }
    }
    
    func performConcurrent() {
        concurrentQueues = (1...100).map { i in DispatchQueue(label: "dev.fummicc1.DispatchConcurrentQueue.concurrent.\(i)", attributes: .concurrent) }
        for queue in concurrentQueues {
            queue.async { [weak self] in
                self?.excute()
            }
            if queue == concurrentQueues.last {
                print("concurrent_done")
            }
        }
    }

    func performSerial() {
        serialQueues = (1...100).map { i in DispatchQueue(label: "dev.fummicc1.DispatchConcurrentQueue.serial.\(i)") }
        for queue in serialQueues {
            queue.async { [weak self] in
                self?.excute()
            }
            if queue == serialQueues.last {
                print("serial_done")
            }
        }
    }
    
    func excute() {
        sleep(1)
    }
}

class ViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

