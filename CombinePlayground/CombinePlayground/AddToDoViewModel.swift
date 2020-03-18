//
//  AddToDoViewModel.swift
//  CombinePlayground
//
//  Created by Fumiya Tanaka on 2020/03/18.
//  Copyright © 2020 Fumiya Tanaka. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

enum AddToDoInputValidationResult {
    case noTitle
    case noContent
    case bothTitleAndContentMissed
    case correct
}

enum AddToDoOutputResult {
    case ready
    case processing
    case success
    case fail(FirestoreClient.Error)
}

class AddToDoViewModel: ObservableObject {
    
    private let firestore: FirestoreClient = FirestoreClient()
    private let auth: AuthClient = AuthClient()

    @Published var title: String = ""
    @Published var content: String = ""
    @Published var deadline: Date = Date()
    
    var objectWillChange = ObservableObjectPublisher()
    
    var outputResult: AddToDoOutputResult = .ready {
        willSet {
            objectWillChange.send()
        }
    }
    var inputValidationResult: AddToDoInputValidationResult = .bothTitleAndContentMissed
    
    func validate(title: String, content: String, deadline: Date) -> AddToDoInputValidationResult {
        if title.isEmpty && content.isEmpty {
            return .bothTitleAndContentMissed
        } else if title.isEmpty {
            return .noTitle
        } else if content.isEmpty {
            return .noContent
        }
        return .correct
    }
    
    func createToDo() {
        self.inputValidationResult = validate(title: title, content: content, deadline: deadline)
        if inputValidationResult  == .correct {
            guard let uid = auth.getUID(), let todo = ToDo(data: [
                "title": title,
                "content": content,
                "sender": uid,
                "deadline": deadline
            ]) else {
                fatalError()
            }
            firestore.createToDo(todo) { [weak self] result in
                switch result {
                case .success:
                    self?.outputResult = .success
                    
                case .failure(let error):
                    self?.outputResult = .fail(error)
                }
            }
        }
    }
}
