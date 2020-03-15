//
//  FirestoreClinet.swift
//  CombinePlayground
//
//  Created by Fumiya Tanaka on 2020/03/15.
//  Copyright © 2020 Fumiya Tanaka. All rights reserved.
//

import Foundation
import Firebase

class FirestoreClient {
    
    enum Error: Swift.Error {
        case noSnapshot
        case someError(Swift.Error)
    }
    
    func listenToDos(of user: String, completion: @escaping (Result<[ToDo], FirestoreClient.Error>) -> ()) -> ListenerRegistration {
        Firestore.firestore().collection("todos").whereField("sender", isEqualTo: user).addSnapshotListener { snapshot, error in
            if let error = error {
                completion(.failure(.someError(error)))
                return
            }
            guard let snapshot = snapshot else {
                completion(.failure(.noSnapshot))
                return
            }
            let todos = snapshot.documents.compactMap { ToDo(data: $0.data()) }
            completion(.success(todos))
        }
    }
    
    func fetchToDos(of user: String, completion: @escaping (Result<[ToDo], FirestoreClient.Error>) -> ()) {
        Firestore.firestore().collection("todos").whereField("sender", isEqualTo: user).getDocuments { snapshot, error in
            if let error = error {
                completion(.failure(.someError(error)))
                return
            }
            guard let snapshot = snapshot else {
                completion(.failure(.noSnapshot))
                return
            }
            let todos = snapshot.documents.compactMap { ToDo(data: $0.data()) }
            completion(.success(todos))
        }
    }
}
