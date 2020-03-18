//
//  ViewModel.swift
//  CombinePlayground
//
//  Created by Fumiya Tanaka on 2020/03/15.
//  Copyright © 2020 Fumiya Tanaka. All rights reserved.
//

import Foundation
import SwiftUI
import Combine
import FirebaseAuth
import FirebaseFirestore.FIRListenerRegistration

struct ToDoSubscription: Subscription {
    var combineIdentifier: CombineIdentifier
    let listener: ListenerRegistration
    func request(_ demand: Subscribers.Demand) {
        
    }
    
    func cancel() {
        listener.remove()
    }
}

struct ToDoListPublisher: Publisher {
    typealias Output = [ToDo]
    typealias Failure = Error
    
    private let firestore: FirestoreClient = .init()
    let ownerUID: String
    
    func receive<S>(subscriber: S) where S : Subscriber, ToDoListPublisher.Failure == S.Failure, ToDoListPublisher.Output == S.Input {
        let listener = firestore.listenToDos(of: ownerUID, completion: { (result) in
            switch result {
            case .success(let todos):
                _ = subscriber.receive(todos)
                
            case .failure(let error):
                subscriber.receive(completion: .failure(error))
            }
        })
        // subscription ≒ Disposable
        let subscription = ToDoSubscription(combineIdentifier: CombineIdentifier(), listener: listener)
        subscriber.receive(subscription: subscription)
    }
}

struct AuthSubscription: Subscription {
    func request(_ demand: Subscribers.Demand) {
    }
    
    func cancel() {
        Auth.auth().removeStateDidChangeListener(authHandler)
    }
    
    let authHandler: AuthStateDidChangeListenerHandle
    var combineIdentifier: CombineIdentifier
    
}

struct AuthPublisher: Publisher {
    typealias Output = User
    typealias Failure = Error
    
    private let auth: AuthClient = .init()
    
    func receive<S>(subscriber: S) where S : Subscriber, Failure == S.Failure, Output == S.Input {
        let authHandler = auth.listenAuthState { user in
            if let user = user {
                _ = subscriber.receive(user)
            } else {
                self.auth.signInAnonymously()
            }
        }
        let subscription = AuthSubscription(authHandler: authHandler, combineIdentifier: CombineIdentifier())
        subscriber.receive(subscription: subscription)
    }
}

final class ViewModel: ObservableObject {
    @Published var todos: [ToDo] = []
    @Published var error: Error?
    @Published var user: User? = nil
    private var isInitialized: Bool = false
    
    private var cancellables: [AnyCancellable] = []
    
    init() {
        let authCancellable = AuthPublisher().sink(receiveCompletion: { _ in
        }) { [unowned self] user in
            self.user = user
            let todoCancellable = ToDoListPublisher(ownerUID: user.uid).replaceError(with: []).assign(to: \Self.todos, on: self)
            self.cancellables.append(todoCancellable)
        }
        cancellables.append(authCancellable)
    }
}
