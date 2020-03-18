//
//  AuthClient.swift
//  CombinePlayground
//
//  Created by Fumiya Tanaka on 2020/03/15.
//  Copyright © 2020 Fumiya Tanaka. All rights reserved.
//

import Foundation
import FirebaseAuth

class AuthClient {
    
    func getUID() -> String? {
        Auth.auth().currentUser?.uid
    }
    
    func listenAuthState(onChanged: @escaping (User?) -> ()) -> AuthStateDidChangeListenerHandle {
        Auth.auth().addStateDidChangeListener { (auth, user) in
            onChanged(user)
        }
    }
    
    func signInAnonymously() {
        Auth.auth().signInAnonymously(completion: nil)
    }
}
