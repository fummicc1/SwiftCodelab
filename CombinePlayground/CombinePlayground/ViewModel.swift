//
//  ViewModel.swift
//  CombinePlayground
//
//  Created by Fumiya Tanaka on 2020/03/15.
//  Copyright © 2020 Fumiya Tanaka. All rights reserved.
//

import Foundation
import SwiftUI
import FirebaseAuth.FIRUser
import FirebaseFirestore.FIRListenerRegistration

final class ViewModel: ObservableObject {
    @Published var todos: [ToDo] = []
    @Published var error: Error?
    @Published var user: User? = nil
    
    private let firestore: FirestoreClient
    private let auth: AuthClient
    private var listener: ListenerRegistration?
    private var isInitialized: Bool = false
    
    init(firestore: FirestoreClient = FirestoreClient(), auth: AuthClient = AuthClient()) {
        self.firestore = firestore
        self.auth = auth
        auth.listenAuthState { [weak self] user in
            if self?.isInitialized == false {
                self?.isInitialized = true
                return
            }
            self?.user = user
            
            if let uid = user?.uid {
                self?.listener = firestore.listenToDos(of: uid, completion: { (result) in
                    switch result {
                    case .success(let todos):
                        self?.todos = todos
                        
                    case .failure(let error):
                        self?.error = error
                    }
                })
            } else {
                auth.signInAnonymously()
                self?.listener?.remove()
                self?.listener = nil
            }
        }
    }
}
